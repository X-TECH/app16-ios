//
//  WelcomeViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createFormButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var nameTextLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setRightBarButton()
        
        let firstName = UserDefaultsHelper.getString(for: .firstName)
        let lastName = UserDefaultsHelper.getString(for: .lstName)
        
        nameLabel.text = (firstName ?? "-") + " " + (lastName ?? "-")
    }
    
    
    private func setUI() {
        
        nameTextLabel.text = "WELCOME".localized()
        createFormButton.setTitle("CREATE_FORM".localized(), for: .normal)
        historyButton.setTitle("HISTORY".localized(), for: .normal)
    }
    
    private func setRightBarButton() {
        
        let editButton = UIBarButtonItem.init(image: UIImage(named: "edit"),
                                              style: .done,
                                              target: self,
                                              action: #selector(editActtions))
        editButton.tintColor = UIColor(red: 0/255, green: 137/255, blue: 40/255, alpha: 1)
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - Actions
    @objc private func editActtions() {
        
    }
    
    @IBAction func createButtonAction(_ sender: UIButton) {
        
        let controller = FormCreateViewController()
        controller.formViewType = .creta
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func historyButtonAction(_ sender: UIButton) {
        
        let controller = FormListViewController()
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
