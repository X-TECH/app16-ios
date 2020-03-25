//
//  CheckBaseHelper.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import Foundation
import UIKit

class CheckBaseHelper {
    
    static func checkBaseResponse(_ baseResponse: BaseResponse, viewController: UIViewController) {
        switch baseResponse {
        case .badRequest:
            let alert = AlertControllerHelper.showAlert(title: "Bed request", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .validationProblem(error: let error):
            let alert = AlertControllerHelper.showAlert(title: error.title, message: error.invalidParams.first?.messages?.first)
            viewController.present(alert, animated: true, completion: nil)
        case .unauthorized:
            let alert = AlertControllerHelper.showAlert(title: "Invalid credentials", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .serviceOffline:
            let alert = AlertControllerHelper.showAlert(title: "Service is Offline", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .notFound:
            let alert = AlertControllerHelper.showAlert(title: "Bad credentials", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .unexpectedError(error: let error):
            let alert = AlertControllerHelper.showAlert(title: error.message, message: nil)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
