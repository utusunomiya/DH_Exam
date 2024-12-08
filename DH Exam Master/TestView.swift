import SwiftUI

struct ExpandableButtonView: View {
    // 小カテゴリの名前
    let subCategory: String
    // DB操作用
    @State private var count: Int = 0
    // ボタンの展開状態
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(subCategory)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                        Spacer()
                        Text("\(count)件")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)

                if isExpanded {
                    VStack(spacing: 10) {
                        Divider()

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
                        .padding(.bottom, 12)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .transition(.opacity)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}

#Preview {
    ExpandableButtonView(subCategory: "カテゴリ1")
}
