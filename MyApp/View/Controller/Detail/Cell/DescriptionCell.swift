//
//  DescriptionCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/14/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet private(set) weak var ratingLbl: UILabel!
    @IBOutlet private(set) weak var likesLbl: UILabel!
    @IBOutlet private(set) weak var addressLbl: UILabel!
    // MARK: - Propeties
    var venueDetail: VenueDetail? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        guard let venue = venueDetail else { return }
        let adress = venue.address ?? ""
        let crossStreet = venue.crossStreet ?? ""
        addressLbl.text = adress + " " + crossStreet
    // TODO: TODO
        ratingLbl.text = "\(venue.ratingPoint)"
        likesLbl.text = "\(venue.likeCount)" + " likes"

    }
}
