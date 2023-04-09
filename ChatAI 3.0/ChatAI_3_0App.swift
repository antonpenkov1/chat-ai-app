//
//  ChatAI_3_0App.swift
//  ChatAI 3.0
//
//  Created by Антон Пеньков on 09.04.2023.
//

import SwiftUI

@main
struct ChatAI_3_0App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
