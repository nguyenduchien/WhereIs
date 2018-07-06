//
//  SettingViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 7/3/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

final class SettingViewController: BaseViewController {

    @IBOutlet private(set) weak var limitTxt: UITextField!
    @IBOutlet private(set) weak var radiusTxt: UITextField!

    @IBOutlet private(set) weak var nearTxt: UITextField!
    let viewModel = SettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        title = App.String.setting

    }

    func updateView() {
        limitTxt.text = viewModel.limits
        radiusTxt.text = viewModel.radius
        nearTxt.text = viewModel.near
    }

    // MARK: - Action

    @IBAction func saveButtonTouchUpInside(_ sender: Any) {
        userDefault.set(limitTxt.text, forKey: App.String.Key.limit)
        userDefault.set(radiusTxt.text, forKey: App.String.Key.radius)
        userDefault.set(nearTxt.text, forKey: App.String.Key.near)
        alert(msg: "Save Success")
    }
}
