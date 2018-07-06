//
//  HomeViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import MapKit

final class HomeViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet private(set) weak var listPlacetableView: UITableView!
    @IBOutlet private(set) weak var mapView: MKMapView!
    @IBOutlet private(set) weak var containMapView: UIView!

    // MARK: - Properties
    var homeViewModel = HomeViewModel()
    private var annotations: [MKAnnotation] = []
    var categoryID: String?
    var isShowMapView: Bool = false
    var center: Coordinate?
    var coordinate: Coordinate? {
        didSet {
            fetchVenues()
        }
    }

    var venues: [Venue] = [] {
        didSet {
            listPlacetableView.reloadData()
            self.addMapAnnotations()
        }
    }

    let locationManager = LocationManager.shared
    lazy var venueSearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = false
        sb.placeholder = App.String.searchplaceholder
        sb.barTintColor =  App.Color.barTinColor
        return sb
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.setupData()
        setupUI()
        addMapAnnotations()
    }
    // MARK: Setup UI
    func setupUI() {
        // navi
        venueSearchBar.delegate = self
        configNavigationItem()
        configTableView()
        configMapView()
        changeContentdislay()
    }
    // MARK: TabbleView
    func configTableView() {
        listPlacetableView.rowHeight    = 70
        listPlacetableView.dataSource   = self
        listPlacetableView.delegate     = self
        listPlacetableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceTable")
        listPlacetableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "VenueCell")
    }
    // MARK: Mapview
    func configMapView() {
        locationManager.configLocationService()
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.didGetLocation = { [weak self] coordinate in
            guard let this = self else { return }
            this.coordinate = coordinate
        }
        mapView.isPitchEnabled = true
        mapView.addSubview(userTrackingButton)
        userTrackingButton.frame = CGRect(x: 10, y: 80, width: 50, height: 50)
        userTrackingButton.tintColor = App.Color.barTinColor
        userTrackingButton.mapView = mapView
    }
    // MARK: Navigation
    @objc func filterCategory() {
    // MARK: ASSIGN DELEGATE
        let categoryvc = CategoryViewController()
        categoryvc.delegate = self
        navigationController?.pushViewController(categoryvc, animated: true)
    }

    func configNavigationItem() {
        title = App.String.home
        let categoryButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_navigation_item_category"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(filterCategory))
        self.navigationItem.rightBarButtonItem = categoryButton
        let viewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_navigation_item_exchangeviewmap"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(exchangeView))
        self.navigationItem.leftBarButtonItem = viewButton
        self.navigationItem.titleView = venueSearchBar
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: IBAction
    // Change display content
    @objc func exchangeView() {
        changeContentdislay()
    }

    func changeContentdislay() {
        isShowMapView = !isShowMapView
        if isShowMapView {
            containMapView.isHidden = false
            listPlacetableView.isHidden = true
            // change image button : List -> Map
            let viewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_navigation_item_exchangeviewlist"), style: .plain, target: self, action: #selector(exchangeView))
            self.navigationItem.leftBarButtonItem = viewButton
        } else {
            containMapView.isHidden = true
            listPlacetableView.isHidden = false
            // change image button : Map -> List
            let viewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_navigation_item_exchangeviewmap"), style: .plain, target: self, action: #selector(exchangeView))
            self.navigationItem.leftBarButtonItem = viewButton
        }
    }
    // Get current location
    lazy var userTrackingButton: MKUserTrackingButton = {
        let trackingButton = MKUserTrackingButton()
        trackingButton.backgroundColor = UIColor.clear
        return trackingButton
    }()
    // FetchVenues
    @IBAction func fetchVenuesButtonTouchUpInside() {
        coordinate = center

    }

    func fetchVenues() {
        if let coordinate = self.coordinate {
            homeViewModel.foursquareClient.fetchVenuesFor(coordinate: coordinate, completion: { (result) in
                switch result {
                case .success(let venues):
                    self.venues = venues
                    self.listPlacetableView.refreshControl?.endRefreshing()
                case .failure(let error):
                    let alert = UIAlertController(title: "Oops!", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            })
        }
    }

    // MARK: - Map Annotations
    func addMapAnnotations() {
        self.removeAnnotations()
        // (1) Loop through venues
        if !venues.isEmpty {
            annotations = venues.map({ venue in
                // (2) create a annotation object
                let point = MKPointAnnotation()
                if let coordinate = venue.location?.coordinate {
                    point.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    point.title = venue.name
                    point.subtitle = venue.categoryName
                }
                return point
            })
            // (3) add annotations to the mapview
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
        }
    }

    func removeAnnotations() {
        if !mapView.annotations.isEmpty {
            for annotation in mapView.annotations {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    @objc func callNumber() {
//        if let phoneCallURL = URL(string: "telprompt://\(String(describing: selectedVenue.contact.phone))") {
//            if (UIApplication.shared.canOpenURL(phoneCallURL)) {
//                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
//            }
//        }
    }
}
// MARK: Tableview Extension
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as? VenueCell else {
            fatalError("Invalid cell dequeue")
        }
        if indexPath.row < venues.count {
            cell.venue = venues[indexPath.row]
        }
//        let venue = venues[indexPath.row]
        cell.foursquareClient = homeViewModel.foursquareClient
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let venue = venues[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.detailViewModel.idVenue = venue.id
        navigationController?.pushViewController(detailVC, animated: true)
        print("didSelectRow \(venue.id)")
    }
}
// MARK: MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.005
        region.span.longitudeDelta = 0.005
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // to change color on annotation already selected
        // if let view = view as? MKMarkerAnnotationView {view.markerTintColor = App.Color.barTinColor}
        // TODO: - find venue (in array) selected when user clicks on pin, where they match, pass the index
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Left Callout Accessory
        if control == view.leftCalloutAccessoryView {
            control.addTarget(self, action: #selector(callNumber), for: UIControlEvents.allTouchEvents)     //Phone call
        }
        // TODO
        let index = annotations.index {$0 === view.annotation}
        guard let annotationIndex = index else {print ("index is nil"); return }
        let venue = venues[annotationIndex]
        let deatilVC = DetailViewController()
        deatilVC.detailViewModel.idVenue = venue.id
        navigationController?.pushViewController(deatilVC, animated: true)
        print("Callout \(venue.id)")
    }

     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // this keeps the user location point as a default blue dot.
        if annotation is MKUserLocation {
            return nil
        }
        // setup annotation view for map - we can fully customize the marker
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView
        // setup annotation view
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
            // right callout
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView?.tintColor = App.Color.barTinColor
            // left callout
            let imageView = UIImageView.init(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width:30, height:30)))
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "ico_bt_direction")
            annotationView?.leftCalloutAccessoryView = imageView
            annotationView?.canShowCallout = true
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = App.Color.barTinColor
            annotationView?.isHighlighted = true
        } else { //display as is
            annotationView?.annotation = annotation
        }
//        searchView.nearSearchBar.isHidden = true
        return annotationView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerMapView = mapView.centerCoordinate
        center = Coordinate(latitude: Double(centerMapView.latitude), longitude: Double(centerMapView.longitude))
    }
}

// MARK: - EXTENSION DELEGATE PROTOCOL CategoryViewControllerDelegate
extension HomeViewController: CategoryViewControllerDelegate {
    func viewController(_ viewController: CategoryViewController, needsPerformAction action: CategoryViewController.Action) {
        switch action {
        case .filter(let id):
            print(id)
            categoryID = id
            guard let coordinate = self.coordinate else {return}
            homeViewModel.foursquareClient.fetchVenuesFor(coordinate: coordinate, query: nil, categoryId: categoryID) { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success(let venues):
                    this.venues = venues
                    this.listPlacetableView.refreshControl?.endRefreshing()
                    this.removeAnnotations()
                    this.addMapAnnotations()
                case .failure(let error):
                    let alert = UIAlertController(title: "Oops!", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okAction)
                    this.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
        }
    }
}
// MARK: SearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // resign keyboard
        searchBar.resignFirstResponder()
        //  validate venue search
        guard let venueSearch = venueSearchBar.text else {return}
        guard !venueSearch.isEmpty else {
            let alertController = UIAlertController(title: "Enter a Venue", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let encodedVenueSearch = venueSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let coordinate = self.coordinate else {return}
        // API Call to get venues
        homeViewModel.foursquareClient.fetchVenuesFor(coordinate: coordinate, query: encodedVenueSearch, categoryId: nil) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let venues):
                this.venues.removeAll()
                this.mapView.removeAnnotations(this.annotations)
                this.annotations.removeAll()
                this.venues = venues
                this.listPlacetableView.refreshControl?.endRefreshing()
                this.removeAnnotations()
                this.addMapAnnotations()
            case .failure(let error):
                let alert = UIAlertController(title: "Oops!", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okAction)
                this.present(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }
//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
// text hasn't changed yet, you have to compute the text AFTER the edit yourself
//    let updatedString = (textField.text as NSString?)?.stringByReplacingCharactersInRange(range, withString: string)
// do whatever you need with this updated string (your code)
// always return true so that changes propagate
//    return true
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText, "<----")
//    }
}
