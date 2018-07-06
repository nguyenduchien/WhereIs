//
//  ListCategoryCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

final class ListCategoryCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private(set) weak var categoryImageView: UIImageView!
    @IBOutlet private(set) weak var nameLbl: UILabel!

    var viewModel: ListCategoryCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameLbl.text = viewModel.name
        categoryImageView.image = UIImage(named: viewModel.imagePath)
    }
}
