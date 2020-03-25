//
//  FormsResponse.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import ObjectMapper

class FormsResponse: Mappable {
    
    var data: [FormCreateResponse]?
   
   
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        
         data <- map["data"]
    }
}

enum FormsResponseResponseData<FormCreateResponse> {
    
    case success(result: FormCreateResponse)
    case base(response: BaseResponse)
    case conflict
    case isOffline
}
