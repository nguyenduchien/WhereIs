//
//  DetailViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

final class DetailViewController: BaseViewController {

    // MARK: Outlet
    @IBOutlet private(set) weak var detailtableView: UITableView!
    @IBOutlet private(set) weak var slidePhotoCollectionView: UICollectionView!
    @IBOutlet private(set) weak var detailMapView: MKMapView!

    // MARK: Properties
    var detailViewModel = DetailViewModel()
    var alertController: UIAlertController?
    private var isAdded: Bool = false
    fileprivate var isLoading = false
    var timer: Timer?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detailViewModel.fetchImagesData { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.slidePhotoCollectionView.reloadData()
            case .failure: break
            }
        }
        detailViewModel.getDataInfo { [weak self] (_) in
            guard let this = self else { return }
            this.configMapView()
            this.configTableView()
        }
        detailViewModel.fetchTipsData { [weak self]  (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.detailtableView.reloadData()
            case .failure: break
            }
        }
    }
    // MARK: SETUP UI
    func setupUI() {
        configNavigationItem()
        configCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(nextButtonTouchUpInside(_:)), userInfo: nil, repeats: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }

    func configNavigationItem() {
        title = App.String.detail
        let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_navigation_item_favorite"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(addFavorite))
        self.navigationItem.rightBarButtonItem = favoriteButton
    }

    func configTableView() {
        detailtableView.register(FeedbackCell.self)
        detailtableView.register(DescriptionCell.self)
        detailtableView.dataSource = self
        detailtableView.delegate = self
    }

    func configCollectionView() {
        slidePhotoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        slidePhotoCollectionView.delegate = self
        slidePhotoCollectionView.dataSource = self
    }

    func configMapView() {
        detailMapView.showsUserLocation = true
        let annotation = MKPointAnnotation()
        guard let venusDetail = detailViewModel.venueDetail else { return }
        annotation.coordinate = CLLocationCoordinate2D(latitude: venusDetail.lat, longitude: venusDetail.long)
        detailMapView.addAnnotation(annotation)
        detailMapView.showAnnotations(detailMapView.annotations, animated: true)
        detailMapView.centerCoordinate = CLLocationCoordinate2D(latitude: venusDetail.lat, longitude: venusDetail.long)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: venusDetail.lat, longitude: venusDetail.long), span: MKCoordinateSpan(latitudeDelta: 1/50, longitudeDelta: 1/50))
        detailMapView.setRegion(region, animated: true)
        annotation.title = detailViewModel.venueDetail?.address
        annotation.subtitle = detailViewModel.venueDetail?.address
        detailMapView.isScrollEnabled = true
        detailMapView.isPitchEnabled = true
        detailMapView.delegate = self
    }

    // MARK: IBAction
    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        let indexPath = detailViewModel.nextBtn()
        if detailViewModel.numberOfImg() == 0 { return }
        slidePhotoCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    @IBAction func previousButtonTouchUpInside(_ sender: Any) {
        let indexPath = detailViewModel.backBtn()
        if detailViewModel.numberOfImg() == 0 { return }
        slidePhotoCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }

    @objc func addFavorite() {
        do {
            let realm = try Realm()
            try realm.write {
                let venueFavorite = VenueFavorite()
                let venueDetail = detailViewModel.venueDetail
                venueFavorite.id = venueDetail?.id
                venueFavorite.name = venueDetail?.name
                let adress = venueDetail?.address ?? ""
                let crossStreet = venueDetail?.crossStreet ?? ""
                venueFavorite.address = adress + " " + crossStreet
                let favs = realm.objects(VenueFavorite.self)
                for item in favs where venueDetail?.id == item.id {
                    isAdded = true
                    alertController = UIAlertController(title: "You added this Venue to Favorite", message: nil, preferredStyle: .alert)
                    guard let alertController = alertController else { return }
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true) {
                        print("You added this Venue to Favorite")
                    }
                }
                if !isAdded {
                    realm.add(venueFavorite)
                    alertController = UIAlertController(title: "Add Favorite Success", message: nil, preferredStyle: .alert)
                    guard let alertController = alertController else { return }
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true) {
                        print("Add Favorite Success")
                    }
                }
            }
        } catch {
            print(error)
        }

    }

    @IBAction func directionButtonTouchUpInside(_ sender: Any) {
        guard let venusDetail = detailViewModel.venueDetail else { return }
        let placeCoordinate = CLLocationCoordinate2D(latitude: venusDetail.lat, longitude: venusDetail.long)
        let directionsURLString = "http://maps.apple.com/?saddr=16.0808178,108.2385833&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
        guard let url = URL(string: directionsURLString) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: { (_) in
        })
    }
}
// MARK: Tableview Extension
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return detailViewModel.numberOfTip()
        }
    }
// MARK: LOADMORE
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
                if isLoading {
                    return
                }
                isLoading = true
                detailViewModel.fetchTipsData(isLoadmore: true) { [weak self] (result) in
                    guard let this = self else { return }
                    this.isLoading = false
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            guard let this = self else { return }
                            this.detailtableView.reloadData()
                        }
                    case .failure: break
                    }
                }
            }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(DescriptionCell.self)
            if let venueDetail = detailViewModel.venueDetail {
                cell.venueDetail = venueDetail
            }
            return cell
        default:
            let cell = tableView.dequeue(FeedbackCell.self)
            cell.updateView(item: detailViewModel.getCommentAt(index: indexPath))
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return detailViewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailViewModel.titleForHeader(section: section)
    }
}

// MARK: Collection Extension
extension DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.numberOfImg()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.updateView(data: detailViewModel.getItemAt(index: indexPath))
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.itemSize
    }
}

extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let drawRoute = DrawRoute()
        if let annotation = view.annotation as? MKPointAnnotation {
            drawRoute.drawRoute(mapView, annotation, mapView.userLocation)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = App.Color.barTinColor
            renderer.lineWidth = Config.lineWidth
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension DetailViewController {

    struct Config {
        static let itemSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        static let lineWidth: CGFloat = 5
    }
}
