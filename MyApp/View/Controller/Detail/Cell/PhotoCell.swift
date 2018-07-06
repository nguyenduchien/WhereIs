//
//  PhotoCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/14/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak private var photoimageView: UIImageView!
    // MARK: - Propeties
    func updateView(data: Data) {
        photoimageView.image = UIImage(data: data)
    }
}
