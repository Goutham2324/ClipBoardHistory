//
//  ClipboardMenuView.swift
//  ClipBoardHistory
//
//  Created by Swejan Kothamasu on 04/11/25.
//

import SwiftUI

struct ClipboardMenuView: View {
    @EnvironmentObject var manager: ClipboardManager
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Clipboard History")
                .font(.headline)
                .padding(.bottom, 5)
            
            Divider()
            
            if manager.history.isEmpty {
                Text("No items yet")
                    .padding(.vertical, 6)
            } else {
                ForEach(manager.history, id: \.self) { item in
                    Button(action: {
                        manager.copyBack(item)
                    }) {
                        Text(item.count > 40 ? String(item.prefix(40)) + "..." : item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            Divider()
            
            Button("Clear History") {
                manager.clearHistory()
            }
            
            SettingsLink {
                Text("Settings…")
            }
            
            Button("Quit") {
                NSApp.terminate(nil)
            }
        }
        .padding(8)
    }
}
