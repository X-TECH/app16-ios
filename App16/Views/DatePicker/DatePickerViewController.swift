//
//  DatePickerViewController.swift
//  Yan
//
//  Created by Grigor Aghabalyan on 2/26/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    // MARK: - RxVariables
    var selectedDate: String?
    
    private var callback: ((String?) -> ())?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePickerView.datePickerMode = .time
       
        datePickerView.locale = Locale(identifier: "hy")
        
    }
    
    func getData(callback: @escaping (String?) -> ()) {
        self.callback = callback
    }
    
    private func dismisView() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        if let hour = components.hour, let minute = components.minute {
            selectedDate = String(format: "%02d:%02d", hour, minute)
        }
    }
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.dismisView()
        callback?(selectedDate)
    }
}
