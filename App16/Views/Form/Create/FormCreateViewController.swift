//
//  FormCreateViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class FormCreateViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var outDateTimeTextFiled: UITextField!
    @IBOutlet weak var outAddressTextFiled: UITextField!
    @IBOutlet weak var destinationAddressTextField: UITextField!
    @IBOutlet weak var planneDateTimeTextField: UITextField!
    
    @IBOutlet weak var destinationTypeTextField:
    UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createButtonAction(_ sender: UIButton) {
        
        if outDateTimeTextFiled.text == ""
            || outAddressTextFiled.text == ""
            || destinationAddressTextField.text == "" || planneDateTimeTextField.text == "" {
            
            let alertController = AlertControllerHelper.showAlert(title: nil, message: "Խնդում ենք լրացրեք բոլոր դաշտերը")
            self.present(alertController, animated: true, completion: nil)
        }else {
            openQrView()
        }
    }
    
    private func openQrView() {
        
        let controller = QrViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
}
