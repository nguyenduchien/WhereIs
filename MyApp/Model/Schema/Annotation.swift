//
//  Annotation.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/6/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import MapKit
// Custom class for storing Annotations for the Map on SearchViewController
class VenueLocation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    // var image: UIImage?
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class VenueLocationView: MKAnnotationView {
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        //        guard let locationPin = self.annotation else { return }
        // TO-DO
    }
}
