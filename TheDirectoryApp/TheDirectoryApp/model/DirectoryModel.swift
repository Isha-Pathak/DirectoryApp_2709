//
//  DirectoryModel.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 25/07/22.
//

import Foundation

struct Employee: Codable,Equatable,Hashable {
    let createdAt: String?
    let firstName: String
    let avatar: URL?
    let lastName: String
    let email: String?
    let jobtitle: String?
    let favouriteColor : String?
    let id : String?
}
struct MeettingRooms: Codable,Equatable,Hashable {
    let createdAt: String?
    var isOccupied: Bool?
    let maxOccupancy: Int?
    let id: String?
}

