//
//  Config.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation

struct Config {
    
    static let ENVIRONMENT = "DEV"
    static let HOST_NAME = "test"
    static let BASE_URL = "https://api." + Config.HOST_NAME + "/data/2.5"
    static let API_TOKEN = ""
    static let API_VERSION = "v1"
    static let API_FORMAT = "json"
    static let DEBUG = true
}
