//
//  DirectoryModel.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 25/07/22.
//

// MARK: - EmployeeElement
typealias Employees = [Employee]

struct Employee: Codable, CellConfigurableModel {
    let createdAt: String
    let firstName: String
    let avatar: String
    let lastName: String
    let email: String
    let jobtitle: String
    let favouriteColor: String
    let id: String
    let data: EmployeeData?
    let to: String?
    let fromName: String?
}

// MARK: - DataClass
struct EmployeeData: Codable {
    let title: String
    let body: String
    let id: String
    let toID: String
    let fromID: String
    let meetingid: String
    
    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}
