//
//  SampleApp_SwiftUIApp.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 22/2/24.
//

import SwiftUI
import SwiftData

@main
struct SampleApp_SwiftUIApp: App {
    var sharedModelContainer: ModelContainer = {
        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
        }
        #endif
        let schema = Schema([Favorite.self])
        let config = ModelConfiguration(for: Favorite.self, isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
