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
    
    @IBOutlet weak var outDateButtonAction: UIButton!
    @IBOutlet weak var planneDateTimeButton: UIButton!
    
    var isCreateMode = false
   
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreateMode {
            createButton.isHidden = false
        }else {
            createButton.isHidden = true
            retriveCurentForm()
        }
    }
    @IBAction func outDateButtonAction(_ sender: UIButton) {
        
        let vc = DatePickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.getData { [weak self] (date) in
            self?.outDateTimeTextFiled.text = date
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func planneDateTimeButtonAction(_ sender: UIButton) {
        
        let vc = DatePickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.getData { [weak self] (date) in
            self?.planneDateTimeTextField.text = date
        }
        self.present(vc, animated: false, completion: nil)
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
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        let date = Date().toString(dateFormat: DateFormat.StandartDate.rawValue)
        
        let form = FormCreateRequestForm(deviceToken: deviceId,
                                         firstName: firstName,
                                         lastName: lastName,
                                         middleName: middleName,
                                         outAddress: outAddressTextFiled.text,
                                         outLatitude: nil,
                                         outLongitude: nil,
                                         outDatetime: outDateTimeTextFiled.text != nil ? date + " " + outDateTimeTextFiled.text! : nil,
                                         visitingAddressAndName: destinationAddressTextField.text,
                                         visitingLatitude: nil,
                                         visitingLongitude: nil,
                                         visitingReason: destinationTypeTextField.text,
                                         plannedReturnDatetime: planneDateTimeTextField.text != nil ? date + " " + planneDateTimeTextField.text! : nil)
        
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
    
    private func retriveCurentForm() {
          
          let form = CurentFormRequestForm(deviceToken: UIDevice.current.identifierForVendor?.uuidString)
          
          CurrentFormService.shered.retrive(data: form) { (weaterResponseData) in
              switch weaterResponseData {
              case .base(response: let baseResposne):
                  CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
              case .success(let response):
                
                DispatchQueue.main.async {
                    self.setData(response: response)
                }
                
              case .isOffline:
                  
                  return
              case .conflict:
    
                
                  return
              }
          }
      }
    
    private func setData(response: FormCreateResponse) {
        
        destinationAddressTextField.isUserInteractionEnabled = false
        planneDateTimeTextField.isUserInteractionEnabled = false
        destinationTypeTextField.isUserInteractionEnabled = false
        destinationAddressTextField.isUserInteractionEnabled = false
        
        outDateButtonAction.isUserInteractionEnabled = false
        planneDateTimeButton.isUserInteractionEnabled = false
        
        outDateTimeTextFiled.isUserInteractionEnabled = false
        planneDateTimeTextField.isUserInteractionEnabled = false
        
        outDateTimeTextFiled.text = response.data?.outDatetime
        outAddressTextFiled.text = response.data?.outAddress
        
        destinationAddressTextField.text = response.data?.visitingAddressAndName
        planneDateTimeTextField.text = response.data?.plannedReturnDatetime
        destinationTypeTextField.text = response.data?.visitingReason
    }
}
