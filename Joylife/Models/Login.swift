//
//  Login.swift
//  Joylife
//
//  Created by alexis on 12/4/21.
//

import Foundation

struct LoginRequest: Codable {
    var email: String
    var password: String

    func isValid() -> Bool {
        return true
    }
}

struct LoginResponse: Codable {
    var isLogin: Bool
}
