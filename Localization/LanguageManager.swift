import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var selectedLanguage = "en" // Default to English
    
    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        selectedLanguage = languageCode
        
        // Reset the app to use the new language
        Bundle.setLanguage(languageCode)
    }
    
    var supportedLanguages: [String] {
        return ["en", "bn", "ja"]
    }
    
    func languageDisplayName(for languageCode: String) -> String {
        switch languageCode {
        case "en":
            return "English"
        case "bn":
            return "Bengali"
        case "ja":
            return "Japanese"
        default:
            return ""
        }
    }
}

extension Bundle {
    fileprivate static var bundleKey: UInt8 = 0
    
    static func setLanguage(_ language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let languageBundle = Bundle(path: path) {
            object_setClass(Bundle.main, LanguageBundle.self)
            objc_setAssociatedObject(Bundle.main, &bundleKey, languageBundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            print("Localization file not found for language: \(language)")
        }
    }

}

class LanguageBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &Bundle.bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}


import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
