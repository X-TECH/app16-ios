//
//  LoginViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextFiled: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightBarButton()
        self.title = "App16"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    private func setUI() {
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "FIRST_NAME".localized(),
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.2)])
        lastNameTextFiled.attributedPlaceholder = NSAttributedString(string: "LAST_NAME".localized(),
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.2)])
        middleNameTextField.attributedPlaceholder = NSAttributedString(string: "MIDDLE_NAME".localized(),
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.2)])
        
        nextButton.setTitle("NEXT".localized(), for: .normal)
    }
    
    private func setRightBarButton() {
          
          let editButton = UIBarButtonItem.init(image: UIImage(named: "settings"),
                                                style: .done,
                                                target: self,
                                                action: #selector(settingsActtions))
        editButton.tintColor = .white
          
          self.navigationItem.rightBarButtonItem = editButton
      }
    
    // MARK: - Navigation
    private func openCreateFormViewController() {
        
        let controller = FormCreateViewController()
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func openWelcomeController() {
        
        let controller = WelcomeViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func setDatUserDef() {
        
        UserDefaultsHelper.set(alias: .firstName, value: firstNameTextField.text)
        UserDefaultsHelper.set(alias: .lstName, value: lastNameTextFiled.text)
        UserDefaultsHelper.set(alias: .middleName, value: middleNameTextField.text)
    }
    
    // MARK: - Actions
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if firstNameTextField.text == ""
            || lastNameTextFiled.text == ""
            || middleNameTextField.text == "" {
            
            let alertController = AlertControllerHelper.showAlert(title: nil, message: "Խնդում ենք լրացրեք բոլոր դաշտերը")
            self.present(alertController, animated: true, completion: nil)
        }else {
            
            setDatUserDef()
            openWelcomeController()
            
        }
    }
    
    // MARK: - Actions
    @IBAction func settingsActtions() {
        
        let controller = SettingsViewController()
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
