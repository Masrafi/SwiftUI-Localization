import SwiftUI

struct ContentView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    
    var body: some View {
        VStack {
            // Display localized text
            Text("welcome_message".localized())
                .padding()
            
            // Language Selection Dropdown
            Picker("Select Language", selection: $languageManager.selectedLanguage) {
                ForEach(languageManager.supportedLanguages, id: \.self) { language in
                    Text(languageManager.languageDisplayName(for: language)).tag(language)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Another localized text
            Text("footer_text".localized())
                .padding()
        }
        .onChange(of: languageManager.selectedLanguage) { oldValue, newValue in
            languageManager.setLanguage(newValue)
        }
    }
}
