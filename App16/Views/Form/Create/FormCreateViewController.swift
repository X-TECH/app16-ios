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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
            createForm()
        }
    }
    
    private func openQrView() {
        
        let controller = QrViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func createForm() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let firstName = UserDefaultsHelper.getString(for: .firstName)
        let lastName = UserDefaultsHelper.getString(for: .lstName)
        let middleName = UserDefaultsHelper.getString(for: .middleName)
        let deviceToken = UserDefaultsHelper.getString(for: .deviceToken)
        
        let form = FormCreateRequestForm(deviceToken: deviceToken,
                                         firstName: firstName,
                                         lastName: lastName,
                                         middleName: middleName,
                                         outAddress: outAddressTextFiled.text,
                                         outLatitude: nil,
                                         outLongitude: nil,
                                         outDatetime: outDateTimeTextFiled.text,
                                         visitingAddressAndName: destinationAddressTextField.text,
                                         visitingLatitude: nil,
                                         visitingLongitude: nil,
                                         visitingReason: destinationTypeTextField.text,
                                         plannedReturnDatetime: planneDateTimeTextField.text)
        
        FormCreateService.shered.createForm(data: form) { (weaterResponseData) in
            switch weaterResponseData {
            case .base(response: let baseResposne):
                self.activityIndicator.stopAnimating()
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let resultsData):
                self.activityIndicator.stopAnimating()
                print(resultsData)
                self.openQrView()
            case .isOffline:
                self.activityIndicator.stopAnimating()
                return
            case .conflict:
                self.activityIndicator.stopAnimating()
                return
            }
        }
    }
}
