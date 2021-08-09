//
//  Signup.swift
//  Joylife
//
//  Created by alexis on 13/4/21.
//

import Foundation

struct SignupRequest: Codable {
    var email: String
    var password: String
}

struct SignupResponse: Codable {
    var errorCode: Int
    var message: String

    var data: Bool?
}
