//
//  DataWebService.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 25/07/22.
//

import Foundation

class ListWebServiceManager {
}
extension ListWebServiceManager : EmployeeDetailProtocol
{
   func fetchEmployeeDetails(completion: @escaping (_ employee : [Employee]?, Error?) -> Void) {
        let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people")
         guard let url = url else {return}
         
         URLSession.shared.dataTask(with: url) { data, urlResponse, error in
             guard let data = data, error == nil, urlResponse != nil else {
                 print("\(error.debugDescription)")
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 
                 let employeeDetails = try decoder.decode([Employee].self, from: data)
                 return completion(employeeDetails, nil)

             }catch {
                 print("Something went wrong", error)
             }
             }.resume()
    }
}
extension ListWebServiceManager : MeetingRoomsProtocol
{
    func fetchMetingRoomDetails(completion: @escaping (_ employee : [MeettingRooms]?, Error?) -> Void) {
         let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms")
          guard let url = url else {return}
          
          URLSession.shared.dataTask(with: url) { data, urlResponse, error in
              guard let data = data, error == nil, urlResponse != nil else {
                  print("\(error.debugDescription)")
                  return
              }
              do {
                  let decoder = JSONDecoder()
                  
                  let employeeDetails = try decoder.decode([MeettingRooms].self, from: data)
                  print(employeeDetails)
                  return completion(employeeDetails, nil)

              }catch {
                  print("Something went wrong", error)
              }
              }.resume()
     }
}
