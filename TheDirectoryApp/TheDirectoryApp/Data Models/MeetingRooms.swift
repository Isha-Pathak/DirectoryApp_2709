//
//  MeetingRooms.swift
//  TheDirectoryApp
//
//  Created by Manju Kiran on 12/10/2022.
//

typealias MeetingRooms = [MeetingRoom]

struct MeetingRoom: Codable, CellConfigurableModel {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}



