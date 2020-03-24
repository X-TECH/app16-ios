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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightBarButton()
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
        
    }
    
    @IBAction func historyButtonAction(_ sender: UIButton) {
        
    }
}
