//
//  Models.swift
//  Simple-Unsplash-App
//
//  Created by ColdBio on 22/12/2021.
//

import Foundation

// Mark
struct Unsplash: Codable, Hashable {
    let id: String?
    let urls: Urls?
    let description: String?
    let user: User?
    let profile_image: ProfileImage?
    let instagram_username: String?
    let total_likes: Int?
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String?
    let thumb: String?
}

struct User: Codable, Hashable {
    let username: String?
}

struct ProfileImage: Codable, Hashable {
    let small, medium, large: String?
}
