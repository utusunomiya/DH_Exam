//
//  selectDetail.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/01.
//

import SwiftUI

struct selectDetail: View {
    //選択された大カテゴリ
    var selectedCategory: String
    //選択された大カテゴリ配下の小カテゴリ
    @State var smallCategories: [String]
    
    @State private var isExpandedList: [Bool]
    
    //初期化処理
    init(selectedCategory: String, categoryManager: CategoryManager = CategoryManager()) {
            self.selectedCategory = selectedCategory
        self.smallCategories = categoryManager.getSubCategories(for: selectedCategory)
        //本当に苦しいんだけど、これが必要な理由がわからん。宣言時でからのリスト渡せばいいのでは
        self.isExpandedList = Array(repeating: false, count: categoryManager.getSubCategories(for: selectedCategory).count)
        
        }

    var body: some View {
        //背景と、ボタンのz軸
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            //画面のy軸
            VStack {
                //紐づく小カテゴリ分繰り返す
                ForEach(smallCategories.indices, id: \.self) {indexCount in
                    
                    VStack {
                        VStack(spacing: 0) {
                            Button {
                                //自身がすでに押されている場合に、選択ボタンをかくのうする必要があるため
                                if isExpandedList.firstIndex(of: true) != indexCount {
                                    //すでに展開している他のボタンを格納する
                                    isExpandedList = isExpandedList.map {_ in false}
                                }
                                    withAnimation {
                                        isExpandedList[indexCount].toggle()
                                    
                                }
                            } label: {
                                VStack {
                                    HStack {
                                        Text("\(smallCategories[indexCount])")
                                            .font(.title)
                                            .foregroundStyle(Color.green)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    
                                    if isExpandedList[indexCount] {
                                        HStack(spacing: 10) {
                                            Button(action: {
                                                // ボタン1のアクション
                                            }) {
                                                Text("1")
                                                    .frame(maxWidth: .infinity)
                                                    .padding()
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(8)
                                            }
                                            
                                            Button(action: {
                                                // ボタン2のアクション
                                            }) {
                                                Text("2")
                                                    .frame(maxWidth: .infinity)
                                                    .padding()
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(8)
                                            }
                                            
                                            Button(action: {
                                                // ボタン3のアクション
                                            }) {
                                                Text("3")
                                                    .frame(maxWidth: .infinity)
                                                    .padding()
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(8)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8) // 最小限の縦方向の余白
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .transition(.opacity)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.white) // 全体を統一した白い背景
                    .cornerRadius(20)
                    .shadow(radius: 4)
                    .padding(.horizontal, 10)
                }
            }
        }.onAppear {if isExpandedList.isEmpty {
            isExpandedList = Array(repeating: false, count: smallCategories.count)
        }}
        HStack {
                        Spacer()
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "globe")
                    Text("HOME")
                        .font(.caption)
                }
            }
                        
                        Spacer()
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "globe")
                    Text("ブックマーク")
                        .font(.caption)
                }
            }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .shadow(radius: 2)
    }
}

#Preview {
    selectDetail(selectedCategory: "歯科医療補助論")
}
