//
//  MainViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retriveCurentForm()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func openLoginViewController() {
        
        let controller = LoginViewController()
         changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func openQRController() {
        
        let controller = QrViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func openWelcomeController() {
        
        let controller = WelcomeViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func retriveCurentForm() {
        
        let form = CurentFormRequestForm(deviceToken: UIDevice.current.identifierForVendor?.uuidString)
        
        CurrentFormService.shered.retrive(data: form) { (weaterResponseData) in
            switch weaterResponseData {
            case .base(response: let baseResposne):
                if UserDefaultsHelper.getString(for: .lstName) == nil {
                    self.openLoginViewController()
                }else {
                    self.openWelcomeController()
                }
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let response):
                UserDefaultsHelper.set(alias: .firstName, value: response.data?.firstName)
                UserDefaultsHelper.set(alias: .lstName, value: response.data?.lastName)
                self.openQRController()
            case .isOffline:
                //self.activityIndicator.stopAnimating()
                return
            case .conflict:
                //self.activityIndicator.stopAnimating()
                return
            }
        }
    }
}
