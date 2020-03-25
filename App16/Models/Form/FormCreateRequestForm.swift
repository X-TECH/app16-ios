//
//  FormCreateRequestForm.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation
import ObjectMapper

class FormCreateRequestForm: Mappable {
    
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
   
    required init?(map: Map) { }
    
    init(deviceToken: String?,
         firstName: String?,
         lastName: String?,
         middleName: String?,
         outAddress: String?,
         outLatitude: Double?,
         outLongitude: Double?,
         outDatetime: String?,
         visitingAddressAndName: String?,
         visitingLatitude: Double?,
         visitingLongitude: Double?,
         visitingReason: String?,
         plannedReturnDatetime: String?) {
        
        self.deviceToken = deviceToken
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.outAddress = outAddress
        self.outLatitude = outLatitude
        self.outLongitude = outLongitude
        self.outDatetime = outDatetime
        self.visitingAddressAndName = visitingAddressAndName
        self.visitingLatitude = visitingLatitude
        self.visitingLongitude = visitingLongitude
        self.visitingReason = visitingReason
        self.plannedReturnDatetime = plannedReturnDatetime
    }
    
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
        
        
    }
}
