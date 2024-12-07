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
                    
                    NavigationLink(destination: selectDetail(selectedCategory: "歯科医療補助論")) {
                        Text("歯科医療補助論")
                            .font(.title)
                            .foregroundStyle(Color.green)
                            .frame(width: 200,height:80)
                            .background(Color.white)
                    }
                    
                    NavigationLink(destination: selectDetail(selectedCategory: "歯科予防処置論")) {
                        Text("歯科予防処置論")
                            .font(.title)
                            .foregroundStyle(Color.green)
                            .frame(width: 200,height:80)
                            .background(Color.white)
                    }
                    
                    NavigationLink(destination: selectDetail(selectedCategory: "歯科保健指導論")) {
                        Text("歯科保険指導論")
                            .font(.title)
                            .foregroundStyle(Color.green)
                            .frame(width: 200,height:80)
                            .background(Color.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)

                    }label: {
                        Text("あ")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

