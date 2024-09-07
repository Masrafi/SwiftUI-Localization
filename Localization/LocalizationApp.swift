//
//  LocalizationApp.swift
//  Localization
//
//  Created by Md Khorshed Alam on 7/9/24.
//

import SwiftUI

@main
struct LocalizationApp: App {
    @ObservedObject var languageManager = LanguageManager.shared
        
        init() {
            if let savedLanguage = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first {
                languageManager.selectedLanguage = savedLanguage
                Bundle.setLanguage(savedLanguage)
            } else {
                languageManager.setLanguage("en") // Default to English
            }
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
