//
//  ClipboardManager.swift
//  ClipBoardHistory
//
//  Created by Swejan Kothamasu on 04/11/25.
//

import AppKit
import Combine

class ClipboardManager: ObservableObject {
    @Published var history: [String] = [] {
        didSet { saveHistory() }
    }
    
    private var lastChangeCount = NSPasteboard.general.changeCount
    private var timer: Timer?
    private let maxItems = 10
    private var ignoreNextChange = false
    
    init() {
        loadHistory()
        startMonitoring()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.checkClipboard()
        }
    }
    
    func checkClipboard() {
        let pasteboard = NSPasteboard.general
        
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount
        
        if ignoreNextChange {
            ignoreNextChange = false
            return
        }
        
        if let text = pasteboard.string(forType: .string), !text.isEmpty {
            addToHistory(text)
        }
    }
    
    
    func addToHistory(_ text: String) {
        if history.first != text {
            history.insert(text, at: 0)
            if history.count > maxItems {
                history.removeLast()
            }
        }
    }
    
    func copyBack(_ text: String) {
        ignoreNextChange = true
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)

        // Remove the selected item
        if let index = history.firstIndex(of: text) {
            history.remove(at: index)
        }
    }
    
    func clearHistory() {
        history.removeAll()
    }
}

// MARK: - 🔒 Persistence
extension ClipboardManager {
    func saveHistory() {
        UserDefaults.standard.set(history, forKey: StorageKeys.history)
    }
    
    func loadHistory() {
        if let saved = UserDefaults.standard.stringArray(forKey: StorageKeys.history) {
            history = saved
        }
    }
}
