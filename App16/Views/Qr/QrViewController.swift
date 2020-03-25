//
//  QrViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit
import AlamofireImage

class QrViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var fomrButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let teviceId = UIDevice.current.identifierForVendor?.uuidString {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            let url = "https://app16.x-tech.am/api/v1/applications/qr_code?device_token=\(teviceId)"
            setImage(url, imageView: qrImageView)
        }
    }
    
    // MARK: - Actions
    @IBAction func formButtonAction(_ sender: UIButton) {
        openCreateFormView()
    }
    
    @IBAction func finshButtonAction(_ sender: UIButton) {
         retriveCurentForm()
        
    }
    
    private func openWelcomeView() {
        
        let controller = WelcomeViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func openCreateFormView() {
        
        let controller = FormCreateViewController()
        controller.formViewType = .viewFromQr
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setImage(_ imageURL: String, imageView: UIImageView) {
        
        if let imageURL = URL(string: imageURL) {
            imageView.af_setImage(withURL: imageURL,
                                  placeholderImage: nil,
                                  filter: nil,
                                  progress: nil,
                                  progressQueue: .main,
                                  imageTransition: .crossDissolve(0.1),
                                  runImageTransitionIfCached: true) { (response) in
                                    self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func retriveCurentForm() {
          
        let form = CurentFormRequestForm(deviceToken: UIDevice.current.identifierForVendor?.uuidString)
        FormFinishService.shered.finishForm(data: form) { (responseData) in
              switch responseData {
              case .base(response: let baseResposne):
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
              case .success(_):
                
                self.openWelcomeView()
              case .isOffline:
                
                return
              case .conflict:
                
                
                  return
              }
          }
      }
}
