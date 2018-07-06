//
//  DrawRoute.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/26/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import MapKit

final class DrawRoute {

    // MARK: - Public
    func drawRoute(_ mapView: MKMapView, _ chooseAnnotation: MKPointAnnotation, _ endAnnotation: MKAnnotation) {
        let chooseCoordinate = chooseAnnotation.coordinate
        let endCoordinate = endAnnotation.coordinate

        let choosePlacemark = MKPlacemark(coordinate: chooseCoordinate, addressDictionary: nil)
        let endPlacemark = MKPlacemark(coordinate: endCoordinate, addressDictionary: nil)

        let chooseMapItem = MKMapItem(placemark: choosePlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)

        let directionRequest = MKDirectionsRequest()
        directionRequest.source = chooseMapItem
        directionRequest.destination = endMapItem
        directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }

            let route = response.routes[0]
            mapView.removeOverlays(mapView.overlays)
            mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)

            let rect = route.polyline.boundingMapRect
            let edge = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
            mapView.setVisibleMapRect(rect, edgePadding: edge, animated: true)
        }
    }
}
