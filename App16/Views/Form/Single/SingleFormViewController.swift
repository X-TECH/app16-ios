//
//  SingleFormViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit
import AlamofireImage

class SingleFormViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
               }
           }
       }
    
    
}
