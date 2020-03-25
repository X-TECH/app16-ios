//
//  FormCreateService.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper
import Alamofire

import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class FormCreateService {
    
    static let shered = FormCreateService()
    
    func createForm(data: FormCreateRequestForm, completion: @escaping ((FormCreateResponseData<FormCreateResponse>) -> Void)) {
        BaseService.shared.post(endpoint: "/applications", object: data.toJSON(), for: .unsecure)
            .responseString { (response) in
                //print(response.result.value ?? "result value is nil")
                if let responseHttp = response.response, let value = response.result.value {
                    if let baseResponse = BaseService.shared.checkBaseResponse(responseHttp, value) {
                        return completion(.base(response: baseResponse))
                    }
                } else {
                    return completion(.isOffline)
                }
                switch response.response?.statusCode ?? 400 {
                case 200:
                    if let value = response.result.value, let data = Mapper<FormCreateResponse>().map(JSONString: value) {
                        return completion(.success(result: data))
                    }
                    return completion(.base(response: .unexpectedError(error: ResponseUnexpectedError.mappingFailed)))
                default:
                    return completion(.base(response: .badRequest))
                }
        }
    }
}
