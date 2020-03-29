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
    
    // MARK: - Variables
    let downloader = ImageDownloader()
    var urlRequest: URLRequest?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloaderQR()
        setUI()
    }
    
    private func setUI() {
        
        fomrButton.setTitle("FORM".localized(), for: .normal)
        finishButton.setTitle("FINISH".localized(), for: .normal)
    }
    
    private func downloaderQR() {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        if let teviceId = UIDevice.current.identifierForVendor?.uuidString {
            urlRequest = URLRequest(url: URL(string: "https://app16.x-tech.am/api/v1/applications/qr_code?device_token=\(teviceId)")!)
            downloader.download(urlRequest!) { response in
                if case .success(let image) = response.result {
                    print(image)
                    self.qrImageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func formButtonAction(_ sender: UIButton) {
        openCreateFormView()
    }
    
    @IBAction func finshButtonAction(_ sender: UIButton) {
        finishCurentForm()
    }
    
    private func openWelcomeView() {
        
        let controller = WelcomeViewController()
        changeRoot(UINavigationController(rootViewController: controller))
    }
    
    private func openCreateFormView() {
        
        let controller = SingleFormViewController()
        
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
    
    // MARK: - Request
    private func finishCurentForm() {
        
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
