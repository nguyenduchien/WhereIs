//
//  BaseViewController.swift
//  MyApp
//
//  Created by Quang Dang N.K on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: App.Color.barTinColor]
    }
}
