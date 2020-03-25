//
//  FormListViewController.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class FormListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Varibales
    private let formListCell = "FormListCell"
    var dataSource: [FormResponse] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        registerCelll()
        
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            retriveCurentForm(deviceToken: deviceId)
        }
    }
    
    // MARK: - Register
    private func registerCelll() {
        
        let nib = UINib(nibName: formListCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: formListCell)
    }
    
    private func retriveCurentForm(deviceToken: String) {
        
        let form = CurentFormRequestForm(deviceToken: UIDevice.current.identifierForVendor?.uuidString)
        
        FormsService.shered.retriveForms(data: form) { (responseData) in
            switch responseData {
            case .base(response: let baseResposne):
                
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let response):
                self.dataSource = response.data ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .isOffline:
                //self.activityIndicator.stopAnimating()
                return
            case .conflict:
                //self.activityIndicator.stopAnimating()
                return
            }
        }
        
    }
}

extension FormListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: formListCell, for: indexPath) as? FormListCell
        cell?.outDateLabel.text = dataSource[indexPath.row].outDatetime
        cell?.planeDateLabel.text = dataSource[indexPath.row].outDatetime
        cell?.createdDateLabel.text = dataSource[indexPath.row].createdAt
        return cell ?? UITableViewCell()
    }
}

extension FormListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        openCreateFormView()
        print(indexPath.row)
    }
    
    private func openCreateFormView() {
        
        let controller = FormCreateViewController()
        controller.isCreateMode = false
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
