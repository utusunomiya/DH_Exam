//
//  DatabaseImporter.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/07.
//

import Foundation
import SQLite

/**
    データベースをインポートするためのクラス
 */
class DatabaseImporter {
    //データベース接続用プロパティ
    private let db: Connection
    
    //テーブルのインスタンス
    private let problems = Table("problems")
    //問題ID
    private let id = SQLite.Expression<Int>("id")
    //問題大カテゴリ
    private let largeCategory = SQLite.Expression<String>("largeCategory")
    //問題小カテゴリ
    private let smallCategory = SQLite.Expression<String>("smallCategory")
    //問題文
    private let sentence = SQLite.Expression<String>("sentence")
    //選択肢 JSON形式で保存し、問題ごとに異なる選択肢数もサポート
    private let options = SQLite.Expression<String>("options")
    //正解番号　JSON形式で保存し、複数正解もサポート
    private let correctAnswer = SQLite.Expression<String>("correctAnswer")
    //解説文
    private let explanation = SQLite.Expression<String>("explanation")
    //最新正誤フラグ
    private let correctFlg = SQLite.Expression<Bool>("correctFlg")
    //最終回答日時
    private let lastAnsweredAt = SQLite.Expression<String?>("lastAnsweredAt")
    //付箋フラグ
    private let tagFlg = SQLite.Expression<Bool>("tagFlg")
    //削除フラグ
    private let deleteFlg = SQLite.Expression<Bool>("deleteFlg")
    
    //クラスの初期化時にデータベースへの接続を設定
    init() throws {
        //データベースのパスを獲得
        let dbPath = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("app_database.sqlite")
            .path
        
        //データベースへ接続
        db = try Connection(dbPath)
        print("INPOSTERDatabase path:\(dbPath)")
    }
    
    /**
     DB初期化処理(テーブル作成とデータ挿入)
     */
    func initializeDatabase() throws {
        //テーブル作成
        try createTable()
        //データ挿入
        try insertInitialData()
    }
    
    /**
     テーブル作成
     */
    private func createTable() throws{
       
        try db.run(problems.create(ifNotExists: true){ t in
            t.column(id,primaryKey: true)
            t.column(largeCategory)
            t.column(smallCategory)
            t.column(sentence)
            t.column(options)
            t.column(correctAnswer)
            t.column(explanation)
            t.column(correctFlg)
            t.column(lastAnsweredAt)
            t.column(tagFlg)
            t.column(deleteFlg)
        })
        print("テーブル作成完了")
            
        }
    
    /**
     CSVカラムを管理するenum
     */
    private enum CSVColumn: Int {
        case largeCategory = 0
        case smallCategory
        case sentence
        case options
        case correctAnswer
        case explanation
        case correctFlg
        case lastAnsweredAt
        case tagFlg
        case deleteFlg
    }
    
    /**
     初期データ挿入
     */
    private func insertInitialData() throws{
        
        //問題データを格納しているフォルダの名称
        let folderName = "problemContent"
        //フォルダ内のファイル一覧を取得
        guard let folderURL = Bundle.main.url(forResource: folderName, withExtension: nil),
              let fileURLs = try? FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil) else {
            throw NSError(domain: "DatabaseImporter", code: 2, userInfo: [NSLocalizedDescriptionKey: "フォルダが見つかりません"])
        }
        
        //フォルダ内のCSVファイルをフィルタリング
        let csvFiles = fileURLs.filter {$0.pathExtension == "csv"}
        if csvFiles.isEmpty {
            print("csvファイルが存在していません。")
            return
        }
        
        //CSVファイル一つ一つを処理する
        for csvFile in csvFiles {
            
            //csvファイルを文字列として読み込む
            let csvData = try String(contentsOf: csvFile, encoding: .utf8)
            //レコードごとに分割
            let rows = csvData.split(separator: "\n")
            
            //各レコードごとに処理をおこなう
            for row in rows.dropFirst() {
                //一つのレコードをカラムごとに分割した配列
                let columns = row.split(separator: ",").map {String($0)}//splitの戻り値はSubstring型であるから、Stringに変換
                
                //カラム数が不足している場合
                guard columns.count >= 10 else {
                    print("不完全なデータがあります")
                    continue
                }
                
                //insert処理
                do {
                    try db.run(problems.insert(
                        largeCategory <- columns[CSVColumn.largeCategory.rawValue],
                        smallCategory <- columns[CSVColumn.smallCategory.rawValue],
                        sentence <- columns[CSVColumn.sentence.rawValue],
                        options <- columns[CSVColumn.options.rawValue],
                        correctAnswer <- columns[CSVColumn.correctAnswer.rawValue],
                        explanation <- columns[CSVColumn.explanation.rawValue],
                        correctFlg <- Bool(columns[CSVColumn.correctFlg.rawValue]) ?? false,
                        lastAnsweredAt <- columns[CSVColumn.lastAnsweredAt.rawValue],
                        tagFlg <- Bool(columns[CSVColumn.tagFlg.rawValue]) ?? false,
                        deleteFlg <- Bool(columns[CSVColumn.deleteFlg.rawValue]) ?? false
                    ))
                } catch {
                    print("データ登録時にエラーが発生しました。")
                }
            }
        }
    }
}
