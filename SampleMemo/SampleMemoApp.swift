//
//  SampleMemoApp.swift
//  SampleMemo
//
//  Created by 神　樹里乃 on 2023/05/21.
//

import SwiftUI

@main
struct SampleMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
