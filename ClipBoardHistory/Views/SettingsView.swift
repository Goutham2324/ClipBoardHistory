//
//  SettingsView.swift
//  ClipBoardHistory
//
//  Created by Swejan Kothamasu on 04/11/25.
//
import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
    @EnvironmentObject var manager: ClipboardManager

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {

            // 🔁 Launch at Login Toggle
            LaunchAtLogin.Toggle("Launch at Login")
                .toggleStyle(.switch)

            Divider()

            // 🧹 Clear history
            Button("Clear Clipboard History") {
                manager.clearHistory()
            }
            .buttonStyle(.borderedProminent)

            Divider()

            // ℹ️ About section
            VStack(alignment: .leading, spacing: 6) {
                Text("Clipsy")
                    .font(.title2.bold())
                Text("Your tiny smart clipboard companion.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Version 1.0")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(20)
        .frame(width: 320)
    }
}
