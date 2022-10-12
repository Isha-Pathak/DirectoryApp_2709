//
//  ViewController.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 25/07/22.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var firmDirectoryButton: UIButton!
    @IBOutlet weak var meetingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meetingButton.layer.cornerRadius = 10.0
        firmDirectoryButton.layer.cornerRadius = 10.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserDefaults.standard.set(nil, forKey: "LocallySavedBookedRooms")
        UserDefaults.standard.set(nil, forKey: "LocallySavedAvailableRooms")
    }

    @IBAction func meetingRoomsDetails(_ sender: Any) {
        
        let meetingRoomViewModel = MeetingRoomViewModel(serviceManager: ListWebServiceManager())
        let listView = ListViewController.create(meetingRoomViewModel)
        self.navigationController?.pushViewController(listView, animated: true)
        
    }
    
    @IBAction func displayEmployeeDetails(_ sender: Any) {
        let employeeViewModel = EmployeeListViewModel(serviceManager: ListWebServiceManager())
        let listView = ListViewController.create(employeeViewModel)
        self.navigationController?.pushViewController(listView, animated: true)
    }
}

