//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Do Linh on 12/20/24.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var viewModel = LocationSearchViewModel()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
