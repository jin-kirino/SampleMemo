//
//  EditMemoView.swift
//  SampleMemo
//
//  Created by 神　樹里乃 on 2023/05/21.
//


import SwiftUI

struct EditMemoView: View {
    // 保存してたメモ内容が格納されている
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var content: String
    private var memo: Memo
    
    // 初期化：元々入ってたデータを自分に返す
    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    
    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .textFieldStyle(.roundedBorder)
                .font(.title)
            TextEditor(text: $content)
                .border(Color.gray, width: 1)
                .font(.body)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveMemo()
                }) {
                    Text("保存")
                }
            }
        }
    }
    
    // データベースに保存する
    private func saveMemo() {
        memo.title = title
        memo.content = content
        memo.updatedAt = Date()

        try? viewContext.save()
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo())
    }
}
