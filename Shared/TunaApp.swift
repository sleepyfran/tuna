//
//  TunaApp.swift
//  Shared
//
//  Created by Fran González on 27.03.2021.
//

import SwiftUI

@main
struct TunaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                InstrumentsView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
