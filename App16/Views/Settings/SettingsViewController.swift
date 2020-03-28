//
//  SettingsViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/28/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var languageTextLabel: UILabel!
    @IBOutlet weak var langaugeLabel: UILabel!
    @IBOutlet weak var langaugeButtob: UIButton!
    
    // MARK: - Variables
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        
        self.appVersionLabel.text = "APP_VERSION".localized() + " - " + Bundle.applicationVersionNumber +
            " ( " + Bundle.applicationBuildNumber + " ) "
        
        // TODO: - Temporary part.
        self.title = "SETTINGS".localized()
        self.languageTextLabel.text = "LANGUAGE".localized()
        self.langaugeLabel.text = UserDefaultsHelper.getString(for: .langauge)
    }
    
    // MARK: - IBAction
    @IBAction func langaugeButtonAction(_ sender: UIButton) {
        
        let controller = LanguageViewController()
        controller.didRefresh
            .bind(onNext: setUI)
            .disposed(by: disposeBag)
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
    }
}
