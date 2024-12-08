//
//  ContentView.swift
//  DH Exam Master
//
//  Created by 矢部勇貴 on 2024/12/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.background)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("問題の種類を選択してください")
                        .font(.largeTitle)
                    Spacer()
                    VStack {
                        NavigationLink(destination: selectDetail(selectedCategory: "歯科医療補助論")) {
                            Text("歯科医療補助論🥺")
                                .font(.title)
                                .foregroundStyle(Color.green)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        
                        NavigationLink(destination: selectDetail(selectedCategory: "歯科予防処置論")) {
                            Text("歯科予防処置論😍")
                                .font(.title)
                                .foregroundStyle(Color.green)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        
                        NavigationLink(destination: selectDetail(selectedCategory: "歯科保健指導論")) {
                            Text("歯科保険指導論🤩")
                                .font(.title)
                                .foregroundStyle(Color.green)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                    }.padding(.horizontal,32)
                    
                    Spacer()
                    
                    HStack {
                                    Spacer()
                                    VStack {
                                        Image(systemName: "globe")
                                        Text("HOME")
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    VStack {
                                        Image(systemName: "globe")
                                        Text("ブックマーク")
                                            .font(.caption)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .shadow(radius: 2)
                    }
                }
            }
        }
    }

#Preview {
    ContentView()
}

