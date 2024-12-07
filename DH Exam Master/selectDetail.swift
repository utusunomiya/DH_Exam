//
//  selectDetail.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/01.
//

import SwiftUI

struct selectDetail: View {
    //受け取った大カテゴリ
    let selectedCategory :String
    //小カテゴリディクショナリクラスのインスタンス
    private let categoryManager = CategoryManager()
    //db接続用クラスインスタンス
    let dbManager = DatabaseManager.shared
    //小カテゴリのリスト
    @State private var subCategories: [String] = []
    //選択された小カテゴリのリスト
    @State private var selectedCategories: [String] = []
    //現在選択されている小カテゴリに該当する問題の件数
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            Text("\(selectedCategory)の詳細分野")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Divider()
            
            List(categoryManager.getSubCategories(for: selectedCategory), id: \.self) {subCategory in
                
                HStack {
                                    Toggle(subCategory,
                                           isOn:Binding(
                                        get: { selectedCategories.contains(subCategory) },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedCategories.append(subCategory)
                                            } else {
                                                selectedCategories.removeAll { $0 == subCategory }
                                            }
                                            count = dbManager.getProblemCount(categories:selectedCategories)
                                        }
                                    ))
                                }
            }
            
            Text ("該当問題数: \(count)問").font(.title)
            
        }
    }
}

#Preview {
    selectDetail(selectedCategory: "歯科医療補助論")
}
