//
//  FavoriteVenueCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/21/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

final class FavoriteVenueCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private(set)weak var addressLbl: UILabel!
    @IBOutlet private(set) weak var nameLbl: UILabel!
    @IBOutlet private(set) weak var likesLbl: UILabel!
    @IBOutlet private(set) weak var photoVenueImageView: UIImageView!
    @IBOutlet private(set) weak var ratingLbl: UILabel!

    var viewModel = FavoriteViewModel()
    var detailViewModel = DetailViewModel()

    func updateView(venue: VenueFavoriteCell) {
        addressLbl.text = venue.item.address
        nameLbl.text = venue.item.name
        guard let id = venue.item.id else { return }
        viewModel.fetchImagesData(id: id) { [weak self](data) in
            guard let this = self, let urlThumbnailImg = URL(string: data) else { return }
            this.photoVenueImageView.sd_setImage(with: urlThumbnailImg, placeholderImage: UIImage(named: "img_place_category"), options: .highPriority, progress: nil, completed: nil)
        }
        DetailAPIClient.shared.getInfo(venueID: id) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let value):
                this.likesLbl.text = String(value.likeCount)
                this.ratingLbl.text = String(value.ratingPoint)
            case .failure(let error): print(error)
            }
        }
    }
}
