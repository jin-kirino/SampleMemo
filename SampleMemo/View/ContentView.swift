//
//  ContentView.swift
//  SampleMemo
//
//  Created by 神　樹里乃 on 2023/05/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    // データの生成、保存、取得を行うために必要なオブジェクト
    @Environment(\.managedObjectContext) private var viewContext

    // @FetchRequestで、データベースを検索する
    // FetchedResults<Memo>型
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default)
    private var fetchedMemoList: FetchedResults<Memo>

    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedMemoList) { memo in
                    VStack {
                        Text(memo.title ?? "")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                        HStack {
                            Text(memo.stringUpdatedAt)
                                .font(.caption)
                                .lineLimit(1)
                            Text(memo.content ?? "")
                                .font(.caption)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteMemo)
            }
            .navigationTitle("メモ")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddMemoView()) {
                        Text("新規作成")
                    }
                }
            }
        }
    }
    // 削除時の処理
    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            viewContext.delete(fetchedMemoList[index])
        }
    // 保存を忘れない
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
