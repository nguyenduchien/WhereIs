//
//  FeedbackCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/14/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class FeedbackCell: UITableViewCell {
        // MARK: - IBOutlets
    @IBOutlet private(set) weak var avatarImageView: UIImageView!
    @IBOutlet private(set) weak var usernameLbl: UILabel!
    @IBOutlet private(set) weak var commentLbl: UILabel!
        // MARK: - Propeties
    func updateView(item: Feedback) {
        commentLbl.text = item.comment
        usernameLbl.text = item.userInfo.firstName + " " + item.userInfo.lastName
        guard let urlImg = URL(string: item.userInfo.image.prefix + "100x100" + item.userInfo.image.sufix) else { return }
        avatarImageView.sd_setImage(with: urlImg)
    }
}
