//
//  DetailWebServiceProtocol.swift.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 26/07/22.
//

protocol EmployeeDetailProtocol {
    func fetchEmployeeDetails(completion: @escaping (_ employees : Employees?, _ error: Error?) -> Void)
}

protocol MeetingRoomsProtocol {
    func fetchMetingRoomDetails(completion: @escaping (_ availableRooms : MeetingRooms?, _ error: Error?) -> Void)
}
