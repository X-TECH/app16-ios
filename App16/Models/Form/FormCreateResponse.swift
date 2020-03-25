//
//  FormCreateResponse.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import ObjectMapper

class FormCreateResponse: Mappable {
    
    var data: FormResponse?

    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        
        data <- map["data"]
    }
}

enum FormCreateResponseData<FormCreateResponse> {
    
    case success(result: FormCreateResponse)
    case base(response: BaseResponse)
    case conflict
    case isOffline
}
