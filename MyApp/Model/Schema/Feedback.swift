//
//  FeedbackModelCell.swift
//  MyApp
//
//  Created by Hien Nguyen on 6/20/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

struct Feedback {
    var userInfo: UserInfo
    var comment: String

    struct UserInfo {
        let firstName: String
        let lastName: String
        let image: Image
    }
    struct Image {
        let sufix: String
        let prefix: String
    }
}
