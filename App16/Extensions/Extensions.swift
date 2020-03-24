//
//  Extensions.swift
//  App16
//
//  Created by Grigor Aghabalyan on 3/25/20.
//  Copyright © 2020 X-TECH. All rights reserved.
//

import UIKit

func getController<T: UIViewController>() -> T {
    return T(nibName: String(describing: T.self), bundle: nil)
}

func changeRoot(_ controller: UIViewController) {
    UIApplication.shared.keyWindow?.rootViewController = controller
}
