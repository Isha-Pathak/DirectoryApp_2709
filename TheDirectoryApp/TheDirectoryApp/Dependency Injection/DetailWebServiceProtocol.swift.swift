//
//  DetailWebServiceProtocol.swift.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 26/07/22.
//

import Foundation


protocol EmployeeDetailProtocol {
    func fetchEmployeeDetails(completion: @escaping (_ employees : [Employee]?, _ error: Error?) -> Void)
}
protocol MeetingRoomsProtocol {
    func fetchMetingRoomDetails(completion: @escaping (_ availableRooms : [MeettingRooms]?, _ error: Error?) -> Void)
}
