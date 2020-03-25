//
//  CurentFormRequestForm.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation
import ObjectMapper

class CurentFormRequestForm: Mappable {
    
    var deviceToken: String?
    
    required init?(map: Map) { }
    
    init(deviceToken: String?) {
        
        self.deviceToken = deviceToken
       
    }
    
    func mapping(map: Map) {
        
        deviceToken <- map["device_token"]
    }
}
