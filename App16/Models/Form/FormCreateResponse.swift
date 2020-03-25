//
//  FormCreateResponse.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import ObjectMapper

class FormCreateResponse: Mappable {
    
    var deviceToken: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var outAddress: String?
    var outLatitude: Double?
    var outLongitude: Double?
    var outDatetime: String?
    var visitingAddressAndName: String?
    var visitingLatitude: Double?
    var visitingLongitude: Double?
    var visitingReason: String?
    var plannedReturnDatetime: String?
    var createdAt: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        
        deviceToken <- map["device_token"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        middleName <- map["middle_name"]
        outAddress <- map["out_address"]
        outLatitude <- map["out_latitude"]
        outLongitude <- map["out_longitude"]
        outDatetime <- map["out_datetime"]
        visitingAddressAndName <- map["visiting_address_and_name"]
        visitingLatitude <- map["visiting_latitude"]
        visitingLongitude <- map["visiting_longitude"]
        visitingReason <- map["visiting_reason"]
        plannedReturnDatetime <- map["planned_return_datetime"]
        createdAt <- map["created_at"]
    }
}

enum FormCreateResponseData<FormCreateResponse> {
    
    case success(result: FormCreateResponse)
    case base(response: BaseResponse)
    case conflict
    case isOffline
}
