//
//  DataWebService.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 25/07/22.
//

import Foundation

protocol WebServiceManaging {
    func fetch<T: Decodable>(url: URL?, completion: @escaping (_ employee : T?, Error?) -> Void)
}

class ListWebServiceManager: WebServiceManaging {
    
    func fetch<T>(url: URL?, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        guard let url = url else {
            completion(nil, NetworkError.invalidURL)
        }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("\(error.debugDescription)")
                return
            }
            do {
                let decoder = JSONDecoder()
                let employeeDetails = try decoder.decode(T.self, from: data)
                completion(employeeDetails, nil)
            }catch {
                print("Something went wrong", error)
                completion(nil, error)
            }
        }.resume()
    }
}
    
    
//   func fetchEmployeeDetails(completion: @escaping (_ employee : Employees?, Error?) -> Void) {
//        let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people")
//         guard let url = url else {return}
//       fetch(url: url, completion: completion)
//    }
//}
//extension ListWebServiceManager : MeetingRoomsProtocol
//{
//    func fetchMetingRoomDetails(completion: @escaping (_ employee : MeetingRooms?, Error?) -> Void) {
//         let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms")
//          guard let url = url else {return}
//
//        fetch(url: url, completion: completion)
//     }
//
//    func fetchMetingRoomDetails2(completion: @escaping (_ employee : MeetingRooms?, Error?) -> Void) {
//         let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/roomsv2")
//          guard let url = url else {return}
//
//        fetch(url: url, completion: completion)
//     }
//}
//
//
//private extension ListWebServiceManager {
//
//
//}
