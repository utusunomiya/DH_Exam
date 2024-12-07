//
//  DatabaseManager.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/04.
//

import SQLite
import Foundation

class DatabaseManager {
    //letで再代入不可とstaticを使用して、シングルトンのdbインスタンスを生成
    static let shared = DatabaseManager();
    //データベースのコネクション
    private var db: Connection
    
    private init() {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory,in: .userDomainMask, appropriateFor: nil, create: true)
        let dbPath = documentDirectory.appendingPathComponent("app_database.sqlite").path
        
        print("MANAGERDatabase path:\(dbPath)")
        do {
            db = try Connection(dbPath)
        }catch {
            print("Error connection to database :\(error)")
            db = try! Connection()
        }
    }
    
    /**
     選択されている小カテゴリに該当する件数を取得するメソッド
     
     */
    public func getProblemCount (categories:[String]) -> Int{
        //categoriesがnilの場合
        if categories.isEmpty {
            return 0
        }
        do {
            let problems = Table("problems")
            let smallCategory = SQLite.Expression<String>("smallCategory")
            //クエリ　SQlite.swiftは自分でsql文を記述しなくてもこうやって作成できる
            let query = problems.filter(categories.contains(smallCategory)).count
            //クエリ処理実行
            let count = try db.scalar(query)
            
            return count
        } catch {
            print ("件数取得時にエラーが発生しました。")
            return 0
        }
    }
}
