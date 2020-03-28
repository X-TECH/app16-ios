//
//  LanguageViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/28/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class LanguageViewController: UIViewController {
    
    // MARK: - IBOutletS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vriables
    private let languageCell = "LanguageCell"
    var langauges: [Language] = []
    let didRefresh = PublishRelay<Void>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langauges.append(Language(title: "Հայերեն", code: "hy"))
        langauges.append(Language(title: "English", code: "en"))
        langauges.append(Language(title: "Русский", code: "ru"))
        
        if let selectedLanguage = UserDefaultsHelper.getString(for: .locale) {
            
            langauges.filter({
                $0.code == selectedLanguage
            }).first?.isSelected = true
        }
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCelll()
        setRightBarButton()
        setUI()
    }
    
    // MARK: - Register
    private func registerCelll() {
        
        let nib = UINib(nibName: languageCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: languageCell)
    }
    
    private func setUI() {
        
        self.title = "LANGUAGES".localized()
        self.navigationItem.leftBarButtonItem?.title = "CANCEL".localized()
    }
    
    private func setRightBarButton() {
        
        let editButton = UIBarButtonItem.init(title: "CANCEL".localized(),
                                              style: .done,
                                              target: self,
                                              action: #selector(closeAction))
        editButton.tintColor = .white
        
        self.navigationItem.leftBarButtonItem = editButton
    }
    
    // MARK: - Actions
    @IBAction func closeAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension LanguageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return langauges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: languageCell, for: indexPath) as? LanguageCell
        cell?.titleLabel.text = langauges[indexPath.row].title
        cell?.checkMarkImageView.isHidden = !langauges[indexPath.row].isSelected
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension LanguageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        langauges.forEach({
            $0.isSelected = false
        })
        langauges[indexPath.row].isSelected = true
        tableView.reloadData()
        setLanguage(index: indexPath.row)
        setUI()
        didRefresh.accept(Void())
    }
    
    private func setLanguage(index: Int) {
        
        Settings.changeLanguage(langauges[index].code, langauge: langauges[index].title)
    }
}
