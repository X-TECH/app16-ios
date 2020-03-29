//
//  SingleFormViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/29/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class SingleFormViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fistNameTextLabel: UILabel!
    @IBOutlet weak var lastNameTextLabel: UILabel!
    @IBOutlet weak var meddleNameTextLabel: UILabel!
    @IBOutlet weak var outDateTimeTextLabel: UILabel!
    @IBOutlet weak var outAddressTextLabel: UILabel!
    @IBOutlet weak var destinationAddressTextLabel: UILabel!
    @IBOutlet weak var planneDateTimeTextLabel: UILabel!
    @IBOutlet weak var destinationTypeTextLabel: UILabel!
    
    @IBOutlet weak var fistNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var meddleNameLabel: UILabel!
    @IBOutlet weak var outDateTimeLabel: UILabel!
    @IBOutlet weak var outAddressLabel: UILabel!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    @IBOutlet weak var planneDateTimeLabel: UILabel!
    @IBOutlet weak var destinationTypeLabel: UILabel!
    
    @IBOutlet weak var curentDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var formData: FormResponse?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        if let data = formData {
            setData(response: data)
        }else {
             retriveCurentForm()
        }
    }
    
    private func setUI() {
        
        self.title = "FORM".localized()
        fistNameLabel.text = "FIRST_NAME".localized()
        lastNameLabel.text = "LAST_NAME".localized()
        meddleNameLabel.text = "MEDDLE_NAME".localized()
        
        outDateTimeTextLabel.text = "OUT_ADDRESS".localized()
        outAddressTextLabel.text = "OUT_DATETIME".localized()
        destinationAddressTextLabel.text = "Address of the place of visit/Title".localized()
        planneDateTimeTextLabel.text = "Estimated Return Time".localized()
        destinationTypeTextLabel.text = "Purpose of the visit".localized()
    }
    
    private func setData(response: FormResponse?) {
        
        fistNameLabel.text = response?.firstName
        lastNameLabel.text = response?.lastName
        meddleNameLabel.text = response?.middleName
        
        outDateTimeLabel.text = response?.outDatetime
        outAddressLabel.text = response?.outAddress
        destinationAddressLabel.text = response?.visitingAddressAndName
        planneDateTimeLabel.text = response?.plannedReturnDatetime
        destinationTypeLabel.text = response?.visitingReason
        curentDateLabel.text = response?.createdAt
    }
    
    private func retriveCurentForm() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let form = CurentFormRequestForm(deviceToken: UIDevice.current.identifierForVendor?.uuidString)
        
        CurrentFormService.shered.retrive(data: form) { (responseData) in
            switch responseData {
            case .base(response: let baseResposne):
                
                self.activityIndicator.stopAnimating()
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let response):
                
                self.activityIndicator.stopAnimating()
                DispatchQueue.main.async {
                    self.setData(response: response.data )
                }
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
