//
//  VenueCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private(set) weak var venueCategoryImageView: UIImageView!
    @IBOutlet private(set) weak var venueNameLabel: UILabel!
    @IBOutlet private(set) weak var venueCategoryLabel: UILabel!
    @IBOutlet private(set) weak var distanceLabel: UILabel!
    @IBOutlet private(set) weak var checkinLabel: UILabel!
    var foursquareClient: FoursquareClient!
    // MARK: - Properties
    var venue: Venue! {
        didSet {
            updateUI()
        }
    }

    // MARK: - setUI
//    func updateUI() {
//        guard let venue = venue else { return }
//        venueNameLabel.text = venue.name
//        venueCategoryLabel.text = venue.categoryName
//        checkinLabel.text = "\(String(describing: venue.checkins))"
//        guard let location = venue.location else { return }
//        distanceLabel.text = "\(String(describing: location.distance))"
//    }

    func updateUI() {
        guard let venue = venue else { return }
        let colorRandom = App.Color.random()
        venueNameLabel.text = venue.name
        venueNameLabel.textColor = colorRandom
        venueCategoryLabel.text = venue.categoryName
        checkinLabel.text = "\(String(describing: venue.checkins))"
//        guard let location = venue.location else { return }
        if let distance = venue.location?.distance {
            distanceLabel.text = "\(distance)mi"
        } else {
            distanceLabel.isHidden = true
        }
        if let foursquareClient = foursquareClient, let categoryURL = venue.categoryIconURL {
            foursquareClient.fetchData(url: categoryURL, completion: { (result) in
                switch result {
                case .success(let data):
                    self.venueCategoryImageView.image = UIImage(data: data)
                    self.venueCategoryImageView.backgroundColor = colorRandom
                    self.venueCategoryImageView.layer.cornerRadius = self.venueCategoryImageView.bounds.width / 2.0
                    self.venueCategoryImageView.layer.masksToBounds = true
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
