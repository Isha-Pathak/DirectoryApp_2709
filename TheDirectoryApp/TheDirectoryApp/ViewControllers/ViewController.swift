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
    }
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(nil, forKey: "LocallySavedBookedRooms")
        UserDefaults.standard.set(nil, forKey: "LocallySavedAvailableRooms")
 

    meetingButton.layer.cornerRadius = 10.0
        firmDirectoryButton.layer.cornerRadius = 10.0

    }

    @IBAction func meetingRoomsDetails(_ sender: Any) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listView.categorySelected = "meetingRooms"
         self.navigationController?.pushViewController(listView, animated: true)
      
    }
    
    @IBAction func displayEmployeeDetails(_ sender: Any) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listView.categorySelected = "people"
         self.navigationController?.pushViewController(listView, animated: true)
    }
}

