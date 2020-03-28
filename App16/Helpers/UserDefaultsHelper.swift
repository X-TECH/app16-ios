//
//  UserDefaultsHelper.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

enum UDAliases: String {
    
    case AuthToken = "auth_token"
    case firstName
    case lstName
    case middleName
    case deviceToken
    case locale = "hy"
    case langauge = "Հայերեն"
}

class UserDefaultsHelper {
    
    static func isNil(_ alias: UDAliases) -> Bool {
        return UserDefaults.standard.string(forKey: alias.rawValue) == nil
    }
    
    static func getString(for alias: UDAliases) -> String? {
        return UserDefaults.standard.string(forKey: alias.rawValue)
    }
    
    static func get(alias: UDAliases) -> Any? {
        return UserDefaults.standard.string(forKey: alias.rawValue)
    }
    
    static func boolFor(alias: UDAliases) -> Bool? {
        return UserDefaults.standard.bool(forKey: alias.rawValue)
    }
    
    static func set(alias: UDAliases, value: String) {
        UserDefaults.standard.set(value, forKey: alias.rawValue)
    }
    
    static func set(alias: UDAliases, value: Any?) {
        UserDefaults.standard.set(value, forKey: alias.rawValue)
    }
    
    static func remove(alias: UDAliases) {
        UserDefaults.standard.removeObject(forKey: alias.rawValue)
    }
    
    static func remove(aliases: UDAliases...) {
        aliases.forEach { (alias) in
            UserDefaults.standard.removeObject(forKey: alias.rawValue)
        }
    }
}
