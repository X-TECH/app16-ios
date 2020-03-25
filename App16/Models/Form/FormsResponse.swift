//
//  FormsResponse.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import ObjectMapper

class FormsResponse: Mappable {
    
    var data: [FormResponse]?
   
   
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        
         data <- map["data"]
    }
}

enum FormsResponseData<FormsResponse> {
    
    case success(result: FormsResponse)
    case base(response: BaseResponse)
    case conflict
    case isOffline
}
