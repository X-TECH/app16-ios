//
//  Language.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/28/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation

class Language {
    
    let title: String
    let code: String
    var isSelected = false
    
    init(title: String, code: String) {
        
        self.title = title
        self.code = code
    }
}
