//
//  DetailViewModel.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/19/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
final class DetailViewModel {

    // MARK: - Properties
    private let sections: [String] = ["Description", "Feedback"]
    private var indexItem = 0
    private var dataImg: [Data] = []
    private var feedBacks: [Feedback] = []
    var idVenue = ""
    fileprivate var offset = 1
    var venueDetail: VenueDetail?

    func backBtn() -> IndexPath {
        if indexItem <= 0 {
            indexItem = dataImg.count
        }
        indexItem -= 1
        let indexPath = IndexPath(item: indexItem, section: 0)
        return indexPath
    }

    func nextBtn() -> IndexPath {
        if indexItem > dataImg.count - 2 {
            indexItem = -1
        }
        indexItem += 1
        let indexPath = IndexPath(item: indexItem, section: 0)
        return indexPath
    }
}

extension DetailViewModel {

    func numberOfImg() -> Int {
        return dataImg.count
    }

    func numberOfTip() -> Int {
        return feedBacks.count
    }

    func numberOfSection() -> Int {
        return sections.count
    }

    func titleForHeader(section: Int) -> String {
        return sections[section]
    }

    func getItemAt(index: IndexPath) -> Data {
        return dataImg[index.row]
    }

    func getCommentAt(index: IndexPath) -> Feedback {
        return feedBacks[index.row]
    }
}

extension DetailViewModel {

    func fetchImagesData(completion: @escaping (Result) -> Void) {
        dataImg.removeAll()
        PhotoAPIClient.manager.getVenuePhotos(venueID: idVenue) { (result) in
            if !result.isEmpty {
                for item in result {
                    let imgUrl = item.prefix + "375x200" + item.suffix // same ratio cell item collectionview
                    ImageHelper.manager.getImage(from: imgUrl, completionHandler: { [weak self] (imageData) in
                        guard let this = self else { return }
                        this.dataImg.append(imageData)
                        completion(.success)
                        }, errorHandler: { (error) in
                            completion(.failure(error: error))
                    })
                }
            }
        }
    }

    func fetchTipsData(isLoadmore: Bool = false, limit: Int = 20, completion: @escaping (Result) -> Void) {
        if !isLoadmore {
            offset = 1
            feedBacks.removeAll()
        }
        TipAPIClient.manager.getVenueTips(venueID: idVenue, limit: limit, offset: offset) { [weak self] (result) in
            guard let this = self else { return }
            if !result.isEmpty {
                this.offset += limit
                for item in result {
                    this.feedBacks.append(Feedback(
                        userInfo: Feedback.UserInfo(firstName: item.user.firstName ?? "",
                                                             lastName: item.user.lastName ?? "",
                                                             image: Feedback.Image(sufix: item.user.photo.suffix, prefix: item.user.photo.prefix)), comment: item.text))
                }
                completion(.success)
            }
        }
    }

    func getDataInfo(completion: @escaping (APIResult<String>) -> Void) {
        DetailAPIClient.shared.getInfo(venueID: idVenue) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let venue):
                this.venueDetail = venue
                completion(.success(""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension DetailViewModel {

    enum Result {
        case success
        case failure(error: AppError)
    }
}
