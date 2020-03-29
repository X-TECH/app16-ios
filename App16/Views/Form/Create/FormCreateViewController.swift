//
//  FormCreateViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

enum FormViewType {
    
    case viewFromList
    case viewFromQr
    case creta
}

import UIKit
import IQKeyboardManagerSwift


class FormCreateViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var curentDate: UILabel!
    @IBOutlet weak var outDateTimeTextFiled: UITextField!
    @IBOutlet weak var outAddressTextFiled: UITextField!
    @IBOutlet weak var destinationAddressTextField: UITextField!
    @IBOutlet weak var planneDateTimeTextField: UITextField!
    @IBOutlet weak var destinationTypeTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var outDateButtonAction: UIButton!
    @IBOutlet weak var planneDateTimeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var outDateTimeTextLabel: UILabel!
    @IBOutlet weak var outAddressTextLabel: UILabel!
    @IBOutlet weak var destinationAddressTextLabel: UILabel!
    @IBOutlet weak var planneDateTimeTextLabel: UILabel!
    @IBOutlet weak var destinationTypeTextLabel: UILabel!
    
    // MARK: - Variables
    var data: FormResponse!
    var formViewType: FormViewType = .creta
    let date = Date().toString(dateFormat: DateFormat.StandartDate.rawValue)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        
        if let firstName = UserDefaultsHelper.getString(for: .firstName),
            let lastName = UserDefaultsHelper.getString(for: .lstName),
            let middleName = UserDefaultsHelper.getString(for: .middleName) {
            nameLabel.text = "\(firstName) \(lastName) \(middleName)"
        }
        
        self.title = "CREATE_FORM".localized()
        createButton.setTitle("CREATE".localized(), for: .normal)
        outDateTimeTextLabel.text = "OUT_ADDRESS".localized()
        outAddressTextLabel.text = "OUT_DATETIME".localized()
        destinationAddressTextLabel.text = "Address of the place of visit/Title".localized()
        planneDateTimeTextLabel.text = "Estimated Return Time".localized()
        destinationTypeTextLabel.text = "Purpose of the visit".localized()
    }
    
    // MARK: - Actions
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
            
            let alertController = AlertControllerHelper.showAlert(title: nil, message: "Please fill in all fields".localized())
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
}
