//
//  DetaillInformationViewController.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 28/07/22.
//

import UIKit

class DetaillInformationViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!//"created at" label for meeting room section
    @IBOutlet weak var emailIdLabel: UILabel!// "is occupied" label for meeting room section
    @IBOutlet weak var jobTitle: UILabel!// "max occuoancy" label for meeting room section
    @IBOutlet weak var favouriteColorLabel: UILabel! // "id" label for meeting room section
    @IBOutlet weak var nameLiteralLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailIdLiteral: UILabel!
    @IBOutlet weak var jobTitleLiteral: UILabel!
    @IBOutlet weak var favouriteColorLiteral: UILabel!
    @IBOutlet weak var idLiteralLabel: UILabel!
    @IBOutlet weak var bookMeetingButton: UIButton!
    var flagForlocallySavedBookedRooms : String = ""
    @IBOutlet weak var detailscrollView: UIScrollView!
    var viewModel = DirectoryViewModel(serviceManager: ListWebServiceManager())
    var employeeDetails:Employee?
    var meetingRoomDeatils : MeetingRoom?
     var listOfMeetingRooms = MeetingRooms() //this parameter will have fetched list of meeting rooms from api

    var categorySelected : String = ""
    var bookedRoomsArray = MeetingRooms()
    var availableRoomArray = MeetingRooms()
    var trackDetailedImage = UIImage()

    //costants
    static let BOOK_MEETING_BUTTON = "Book Meeting Room"
      static let AVAILABLE_MEETING_BUTTON = "Release Meeting Room"
     static let AVAIALBLE_ROOM = "Meeting Room is available"
      static let BOOKED_ROOM = "Meeting Room is occupied"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        detailscrollView.contentOffset.y = -20.0
        self.navigationController?.navigationBar.topItem?.title = " "

        profilePhoto.image = trackDetailedImage
        if categorySelected == "meetingRooms"
        {
            setupViewForMeetingRoomDetails()
        }
        else if categorySelected == "people"
        {
            setupViewsForEmployee()
        }
        ///fetching deatils from plist
        if let data = UserDefaults.standard.data(forKey: "LocallySavedBookedRooms") {
            do {
        let decoder = JSONDecoder()
                bookedRoomsArray = try decoder.decode(MeetingRooms.self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "LocallySavedAvailableRooms") {
            do {
        let decoder = JSONDecoder()
                availableRoomArray = try decoder.decode(MeetingRooms.self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    func setupViewsForEmployee()
    {
        if (employeeDetails?.firstName) != nil
        {
            if (employeeDetails?.lastName) != nil
            {
                nameLiteralLabel.text = "\(employeeDetails!.firstName) \(employeeDetails!.lastName)"
            }
            else
            {
                nameLiteralLabel.text = "\(employeeDetails!.firstName)"
            }
        }
        else
        {
            nameLiteralLabel.text = " "
        }
        if let email = employeeDetails?.email
        {
            emailIdLiteral.text = email
        }
        else
        {
            emailIdLiteral.text = " "
        }
        if let jobTitle = employeeDetails?.jobtitle
        {
            jobTitleLiteral.text = jobTitle
        }
        else
        {
            jobTitleLiteral.text = " "
        }
        if let favColor = employeeDetails?.favouriteColor
        {
            favouriteColorLiteral.text = favColor
        }
        else
        {
            favouriteColorLiteral.text = " "
        }
        if let id = employeeDetails?.id
        {
            idLiteralLabel.text = id
        }
        else
        {
            idLiteralLabel.text = " "
        }
            bookMeetingButton.isHidden = true
    }
    func setupViewForMeetingRoomDetails()
    {
        bookMeetingButton.isHidden = false
        bookMeetingButton.layer.borderWidth = 2.0
        bookMeetingButton.layer.borderColor = UIColor.white.cgColor
        nameLabel.text = "Created At:"
        if let createdAt = meetingRoomDeatils?.createdAt
        {
            nameLiteralLabel.text = createdAt
        }
        
        emailIdLabel.text = "Is Occupied:"
        if let isOccupied = meetingRoomDeatils?.isOccupied
        {
            if isOccupied == true
            {
                if flagForlocallySavedBookedRooms == "true"
                {
                    emailIdLiteral.text = DetaillInformationViewController.BOOKED_ROOM
                    bookMeetingButton .setTitle(DetaillInformationViewController.AVAILABLE_MEETING_BUTTON, for: .normal)

                }
                else{
                    emailIdLiteral.text = DetaillInformationViewController.AVAIALBLE_ROOM
                    bookMeetingButton .setTitle(DetaillInformationViewController.BOOK_MEETING_BUTTON, for: .normal)
                }
            }
            else
            {
                if flagForlocallySavedBookedRooms == "true"
                {
                    emailIdLiteral.text = DetaillInformationViewController.BOOKED_ROOM
                    bookMeetingButton .setTitle(DetaillInformationViewController.AVAILABLE_MEETING_BUTTON, for: .normal)

                }
                else
                {
                    emailIdLiteral.text = DetaillInformationViewController.AVAIALBLE_ROOM
                    bookMeetingButton.titleLabel?.text = DetaillInformationViewController.BOOK_MEETING_BUTTON

                }
            }
        }
        
        jobTitle.text = "Max Occupancy:"
        if let maxOccupancy = meetingRoomDeatils?.maxOccupancy
        {
            jobTitleLiteral.text = String(maxOccupancy)
        }
        
        favouriteColorLabel.text = "ID:"
        if let id = meetingRoomDeatils?.id
        {
            favouriteColorLiteral.text = id
        }
        idLabel.isHidden = true
        idLiteralLabel.isHidden = true
        }

    @IBAction func bookMeeting(_ sender: Any) {
       
        // Create JSON Encoder
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        //condition for booking a meeting room
        if bookMeetingButton.titleLabel?.text == DetaillInformationViewController.BOOK_MEETING_BUTTON
        {
            let alert : UIAlertController = UIAlertController(title: "Meeting Room Booked Successfully!", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailIdLiteral.text = DetaillInformationViewController.BOOKED_ROOM
            bookedRoomsArray.append(meetingRoomDeatils! )
            bookMeetingButton .setTitle(DetaillInformationViewController.AVAILABLE_MEETING_BUTTON, for: .normal)
          do {

                // Encode data
                let data = try encoder.encode(bookedRoomsArray)
                // Write Data to booked room  array
                UserDefaults.standard.set(data, forKey: "LocallySavedBookedRooms")

            } catch {
                print("Unable to Encode LocallySavedBookedRooms (\(error))")
            }
            
            if let data = UserDefaults.standard.data(forKey: "LocallySavedAvailableRooms") {
                do {
                    // Create JSON Decoder
                    let locallySavedAvailbleRooms = try decoder.decode(MeetingRooms.self, from: data)
                        
                        let searchedID = meetingRoomDeatils?.id
                        for i  in  0..<locallySavedAvailbleRooms.count
                        {
                            let dict = locallySavedAvailbleRooms[i]
                            let availableID = dict.id
                            if searchedID == availableID
                            {
                                availableRoomArray .remove(at: i)
                            }
                        }
                    let encoder = JSONEncoder()

                    // Encode data
                    let data = try encoder.encode(availableRoomArray)

                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "LocallySavedAvailableRooms")
                } catch {
                    print("Unable to Decode Notes (\(error))")
                }
            }
        }
        else
        {
            //condition for making booked room availble
            let alert : UIAlertController = UIAlertController(title: "Meeting Room Released Successfully!", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailIdLiteral.text = DetaillInformationViewController.AVAIALBLE_ROOM
            bookMeetingButton .setTitle(DetaillInformationViewController.BOOK_MEETING_BUTTON, for: .normal)
            
            if let data = UserDefaults.standard.data(forKey: "LocallySavedBookedRooms") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    let locallySavedBookedRooms = try decoder.decode(MeetingRooms.self, from: data)
                        
                        let searchedID = meetingRoomDeatils?.id
                        for i  in  0..<locallySavedBookedRooms.count
                        {
                        
                            let dict = locallySavedBookedRooms[i]
                            let availableID = dict.id
                            if searchedID == availableID
                            {
                                 bookedRoomsArray .remove(at: i)
                            }
                        }
                        
                    let encoder = JSONEncoder()

                    // Encode data
                    let data = try encoder.encode(bookedRoomsArray)
                
                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "LocallySavedBookedRooms")
                } catch {
                    print("Unable to Decode Notes (\(error))")
                }
                availableRoomArray.append(meetingRoomDeatils! )
              do {
                    // Create JSON Encoder
                    let encoder = JSONEncoder()

                    // Encode data
                    let data = try encoder.encode(availableRoomArray)
                
                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "LocallySavedAvailableRooms")

                } catch {
                    print("Unable to Encode LocallySavedBookedRooms (\(error))")
                }
            }
            else
            {
                availableRoomArray.append(meetingRoomDeatils! )
              do {
                    // Create JSON Encoder
                    let encoder = JSONEncoder()

                    // Encode data
                    let data = try encoder.encode(availableRoomArray)
                
                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "LocallySavedAvailableRooms")

                } catch {
                    print("Unable to Encode LocallySavedBookedRooms (\(error))")
                }
            }
        }
}

}
