//
//  BudgetAppV1App.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/18/23.
//

import SwiftUI
import SunburstDiagram

@main
struct BudgetAppV1App: App {
    @StateObject private var manager: DataManager = DataManager()
    var body: some Scene {
         
        WindowGroup {
            HomePage()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
