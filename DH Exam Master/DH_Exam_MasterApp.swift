//
//  DH_Exam_MasterApp.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/01.
//
import SwiftUI

@main
struct DH_Exam_MasterApp: App {
    //アプリ起動時
    init() {
        //データベース構築
        do {
            let importer = try DatabaseImporter()
            print("DBインスタンス生成完了")
            try importer.initializeDatabase()
            print("初期化完了")
        } catch {
            print("DBの初期化時にエラーが発生しました。\(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
