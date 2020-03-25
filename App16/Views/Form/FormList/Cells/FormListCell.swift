//
//  FormListCell.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

class FormListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var outDateLabel: UILabel!
    @IBOutlet weak var planeDateLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
