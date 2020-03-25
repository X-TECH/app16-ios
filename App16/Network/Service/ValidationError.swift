//
//  ValidationError.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation
import ObjectMapper

class ValidationError: Mappable {
    
    var type: String = ""
    var title: String = ""
    var detail: String = ""
    var invalidParams: [ValidationErrorFields] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        title <- map["error.message"]
        detail <- map["detail"]
        invalidParams <- map["error.fields"]
    }
    
}

class ValidationErrorFields: Mappable {
    
    var key: String?
    var messages: [String]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        key <- map["key"]
        messages <- map["messages"]
    }
    
}

class InvalidParam: Mappable {
    var param: String?
    var code: String?
    var reason: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        param <- map["param"]
        code <- map["code"]
        reason <- map["reason"]
    }
}

class ResponseUnexpectedError: Mappable {
    var timestamp: String = ""
    var status: Int = 0
    var error: String = ""
    var exception: String = ""
    var message: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        timestamp <- map["timestamp"]
        status <- map["status"]
        error <- map["error"]
        exception <- map["exception"]
        message <- map["message"]
    }
    
    init(status: Int, error: String, exception: String, message: String) {
        timestamp = DateFormattingHelper.stringFrom(date: Date(), format: DateFormat.LongDate)
        self.status = status
        self.error = error
        self.exception = exception
        self.message = message
    }
    
    static let mappingFailed = ResponseUnexpectedError(
        status: 4003,
        error: "Failed to Map",
        exception: "Mapping",
        message: "Unable to map response data"
    )
    
    static let badRequest = ResponseUnexpectedError(
        status: 4001,
        error: "Failed to request",
        exception: "InvalidRequest",
        message: "Something wrong was done in my end"
    )
}
