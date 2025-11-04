//
//  ClipBoardHistoryApp.swift
//  ClipBoardHistory
//
//  Created by Swejan Kothamasu on 04/11/25.
//

import SwiftUI

@main
struct ClipBoardHistoryApp: App {
    @StateObject private var manager = ClipboardManager()

    var body: some Scene {
        MenuBarExtra("ClipBoard", systemImage: "clipboard") {
            ClipboardMenuView()
                .environmentObject(manager)
        }
        .menuBarExtraStyle(.window)
    }
}
