//
//  User.swift
//  SwiftViper
//
//  Created by Muhammad Arif on 04/06/25.
//

import Foundation

struct UserParam: Codable {
    let username: String
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct UserResponse: Codable {
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let accessToken, refreshToken: String

    //    init(id: Int, username: String, email: String, firstName: String, lastName: String, gender: String, image: String, accessToken: String, refreshToken: String) {
    //        self.id = id
    //        self.username = username
    //        self.email = email
    //        self.firstName = firstName
    //        self.lastName = lastName
    //        self.gender = gender
    //        self.image = image
    //        self.accessToken = accessToken
    //        self.refreshToken = refreshToken
    //    }

    static var mock: UserResponse {
        UserResponse(
            id: 1, username: "ArifMuhammada", email: "arif@gmail.com",
            firstName: "Muhammad", lastName: "Arif", gender: "Laki-laki",
            image: Constants.randomImage, accessToken: "", refreshToken: "")
    }
}

//{
//  "id": 1,
//  "username": "emilys",
//  "email": "emily.johnson@x.dummyjson.com",
//  "firstName": "Emily",
//  "lastName": "Johnson",
//  "gender": "female",
//  "image": "https://dummyjson.com/icon/emilys/128",
//  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
//  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
//}
