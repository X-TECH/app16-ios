//
//  Settings.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation
import CoreLocation
import Localize_Swift

struct Settings {
    
    enum YEREVAN: Double {
        case latitude = 40.178576
        case longitude = 44.511739
    }
    
    enum Languages: String {
        case Armenian = "hy"
        case English = "en"
        case Russian = "ru"
    }
    
    static func changeLanguage(_ code: String, langauge: String) {
        
        Settings.language = code
        Localize.setCurrentLanguage(Settings.language)
        
        UserDefaultsHelper.set(alias: .locale, value: code)
        UserDefaultsHelper.set(alias: .langauge, value: langauge)
        UserDefaults.standard.set(code, forKey: "language")
        UserDefaults.standard.synchronize()
    }
    
    static var language: String! {
        set(token) {
            let defaults = Foundation.UserDefaults.standard
            defaults.set(token, forKey: "User.Language")
        }
        get {
            let defaults = Foundation.UserDefaults.standard
            let lang = defaults.object(forKey: "User.Language") as? String
            return lang
        }
    }
}
