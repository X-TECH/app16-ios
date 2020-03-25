//
//  QrViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class QrViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var fomrButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func formButtonAction(_ sender: UIButton) {
        
        openCreateFormView()
    }
    
    @IBAction func finshButtonAction(_ sender: UIButton) {
        
        openWelcomeView()
    }
    
    private func openWelcomeView() {
        
        let controller = WelcomeViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func openCreateFormView() {
        
        let controller = FormCreateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
