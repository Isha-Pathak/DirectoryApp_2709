//
//  MeetingRoomViewModel.swift
//  TheDirectoryApp
//
//  Created by Manju Kiran on 12/10/2022.
//

// S   ingle-responsibility principle: "There should never be more than one reason for a class to change."[5] In other words, every s should have only one responsibility.[6]
// O    pen–closed principle: "Software entities ... should be open for extension, but closed for modification."[7]
// L     iskov substitution principle: "Functions that use pointers or references to base classes must be able to use objects of ved classes without knowing it."[8] See also design by contract.[8]
// I    nterface segregation principle: "Clients should not be forced to depend upon interfaces that they do not use."[9][4]
// D  ependency inversion principle: "Depend upon abstractions, [not] concretions."[10][4]


class MeetingRoomViewModel: ListViewModel, MeetingRoomsProtocol {
        
    private let serviceManager: WebServiceManaging
    private var meetingRooms = MeetingRooms() {
        didSet {
            listDisplaying?.refreshList()
        }
    }
    
    weak var listDisplaying: ListDisplaying?
    var count: Int {
        meetingRooms.count
    }
    
    init(serviceManager: WebServiceManaging) {
        self.serviceManager = serviceManager
    }
    
    func refreshData() {
        refreshMeetingRoom()
    }
    
    private func refreshMeetingRoom() {

        let completionHandler: (MeetingRooms?, Error?) -> Void = { (availableRooms, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let availableRooms = availableRooms  else { return }
            self.meetingRooms = availableRooms
        }
    }
    
    func configureCell(cell: ConfigurableCell, indexPath: IndexPath) {
        cell.configure(with: meetingRooms[indexPath.row])
    }
}

extension String {
    
    func addAnotherString(string: String) -> String {
        return self + string
    }
    
    func append(_ other: String) {
        
    }
}
