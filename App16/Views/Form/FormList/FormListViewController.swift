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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        registerCelll()
    }
    
    // MARK: - Register
    private func registerCelll() {
        
        let nib = UINib(nibName: formListCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: formListCell)
    }
}

extension FormListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: formListCell, for: indexPath) as? FormListCell
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
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
