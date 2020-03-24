//
//  BaseResponse.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation

enum BaseResponse {
    
    
    case serviceOffline
    
    /* http status code 400 */
    case badRequest
    
    /* http status code 401 */
    case unauthorized
    
    /* http status code 404 */
    case notFound
    
    /* http status code 422 */
    case validationProblem(error: ValidationError)
    
    /* http status code 500 */
    case unexpectedError(error: ResponseUnexpectedError)
}
