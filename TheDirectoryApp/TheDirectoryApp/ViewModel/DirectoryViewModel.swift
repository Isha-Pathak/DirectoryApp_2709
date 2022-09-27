//
//  ListDetailsViewModel.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 26/07/22.
//

import Foundation

class DirectoryViewModel {
    
    private let serviceManager: ListWebServiceManager
    
    init(serviceManager: ListWebServiceManager) {
        self.serviceManager = serviceManager
    }
    
    public func fetchEmployeeDetails(completion: @escaping (_ employees : [Employee]?, _ error: Error?) -> Void)
    {
        serviceManager.fetchEmployeeDetails() { (employeeList, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let employeeList = employeeList  else { return }
            return completion(employeeList, nil)
        }
    }
    public func fetchMeetingRoomsDetails(completion: @escaping (_ availableRooms : [MeettingRooms]?, _ error: Error?) -> Void) {

        serviceManager.fetchMetingRoomDetails() { (availableRooms, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let availableRooms = availableRooms  else { return }
            return completion(availableRooms, nil)
        }
    }
}
