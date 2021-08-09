//
//  UserPosts.swift
//  Joylife
//
//  Created by alexis on 14/4/21.
//

import Foundation
import SwiftUI

struct UserPosts: Hashable {
    var username: String?
    var userAvatar: String?
    var likes: Int?
    var title: String?
    var text: String?
    var image: String

    init(image: String) {
        self.image = image
        self.username = "alexis123"
        self.likes = 100
        self.title = "你好 生活"
        self.text = "123123123123"
        self.userAvatar = "avatar"
    }

    static func ==(lhs: UserPosts, rhs: UserPosts) -> Bool {
        return lhs.image == rhs.image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}


