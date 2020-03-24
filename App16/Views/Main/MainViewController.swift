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
        
      openLoginViewController()

    }
    
    private func openLoginViewController() {
        
        let controller = LoginViewController()
        changeRoot(controller)
    }
    
    private func openFormCreateController() {
        
        let controller = FormCreateViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
}
