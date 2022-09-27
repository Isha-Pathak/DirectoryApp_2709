//
//  ListViewController.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 27/07/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var bookedRoomsButton: UIButton!
    @IBOutlet weak var availableRoomsButton: UIButton!
    private var listOfEmployee = [Employee]() //this parameter will have fetched list of employees from api
    private var listOfMeetingRooms = [MeettingRooms]() //this parameter will have fetched list of meeting rooms from api
    var avaiableRoomList = [MeettingRooms]() //filtered list of available meeting rooms from "listOfMeetingRooms"
    var bookedRoomList = [MeettingRooms]() // filtered list of booked meeting rooms from "listOfMeetingRooms"
    var viewModel = DirectoryViewModel(serviceManager: ListWebServiceManager()) //view model object
    var categorySelected : String = "" // flag after slecting employee or meting room
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var selectedRoomCategory : String = ""
    
    //constants
    static let MEETING_ROOMS = "meetingRooms"
    static let PEOPLE = "people"
    static let BOOKED_ROOMS = "BookedRooms"
    static let AVAILABLE_ROOMS = "AvailableRooms"
    static let AVAILABLE_ROOMS_SAVED_LOCALLY =  "LocallySavedAvailableRooms"
    static let BOOKED_ROOMS_SAVED_LOCALLY = "LocallySavedBookedRooms"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.topItem?.title = " "
        setUpActivityView()
        
        //setting up views
        availableRoomsButton.layer.borderWidth = 2.0
        availableRoomsButton.layer.borderColor = CGColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        listTableView.contentOffset.y = -20.0
        bookedRoomsButton.layer.borderWidth = 2.0
        bookedRoomsButton.layer.borderColor = CGColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        
        loadList()
}
    func setUpActivityView()
    {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.bookedRoomsButton.titleLabel?.textColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        // handling scenarios of app in background and foreground
        let foregroundNotificationCenter = NotificationCenter.default
        foregroundNotificationCenter.addObserver(self, selector:#selector(handleUIInBakgroundModes),name: UIApplication.willEnterForegroundNotification, object: nil)
        //
        
        if categorySelected == ListViewController.MEETING_ROOMS
        {
        self.title = "Meeting Rooms"
        }
        else if categorySelected == ListViewController.PEOPLE
        {
            self.title = "Emplyoees"
        }
        self.bookedRoomsButton.titleLabel?.textColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        updateUIForAvailableRooms()
    }
    @objc func handleUIInBakgroundModes()
    {
        updateUIForAvailableRooms()
    }
    private func loadList()
    {
        activityIndicator.startAnimating()
        if categorySelected == ListViewController.MEETING_ROOMS
        {
            bookedRoomsButton.isHidden = false
            availableRoomsButton.isHidden = false
            viewModel.fetchMeetingRoomsDetails(completion: { list, error in
                
                    if let error = error {
                        print("Error : \(error.localizedDescription)")
                        return
                    }
                    guard let listOfRooms = list  else { return }
                self.listOfMeetingRooms = listOfRooms
                DispatchQueue.main.async {
                    self.updateUIForAvailableRooms()
                    self.listTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            })
        }
        else if categorySelected == ListViewController.PEOPLE
        {
            bookedRoomsButton.isHidden = true
            availableRoomsButton.isHidden = true
            viewModel.fetchEmployeeDetails(completion: { employeeList, error in
                
                    if let error = error {
                        print("Error : \(error.localizedDescription)")
                        return
                    }
                    guard let employeeList = employeeList  else { return }
                    self.listOfEmployee = employeeList
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                })
        }
    }
    
    @IBAction func displayBookedRooms(_ sender: Any) {
        activityIndicator.startAnimating()
        selectedRoomCategory = ListViewController.BOOKED_ROOMS
        bookedRoomsButton.backgroundColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        availableRoomsButton.backgroundColor = UIColor.clear
        availableRoomsButton.titleLabel?.textColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        //filtered data of booked rooms from list of all meeting rooms api
        let filtered = self.listOfMeetingRooms.filter { $0.isOccupied == true }
        bookedRoomList = filtered
        //fetching locally saved booked rooms details from user defaults
        if let data = UserDefaults.standard.data(forKey: ListViewController.BOOKED_ROOMS_SAVED_LOCALLY) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let locallySavedBookedRooms = try decoder.decode([MeettingRooms].self, from: data)
                
                bookedRoomList.append(contentsOf: locallySavedBookedRooms)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: ListViewController.AVAILABLE_ROOMS_SAVED_LOCALLY) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let locallyAvailableRooms = try decoder.decode([MeettingRooms].self, from: data)
                for  object in locallyAvailableRooms{
                    
                    let searchedID = object.id
                    for i  in  0..<bookedRoomList.count-1
                    {
                        let dict = bookedRoomList[i]
                        let availableID = dict.id
                        if searchedID == availableID
                        {
                            bookedRoomList .remove(at: i)
                        }
                    }
                }
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        self.listTableView.reloadData()
        activityIndicator.stopAnimating()
        
    }
    @IBAction func displayAvailableRooms(_ sender: Any) {
        selectedRoomCategory = ListViewController.AVAILABLE_ROOMS
        activityIndicator.startAnimating()
        updateUIForAvailableRooms()
    }
    
    func updateUIForAvailableRooms()
    {
        selectedRoomCategory = ListViewController.AVAILABLE_ROOMS

        self.availableRoomsButton.setTitleColor(UIColor.white, for: .normal)
      self.availableRoomsButton.backgroundColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        self.bookedRoomsButton.backgroundColor = UIColor.clear
        self.bookedRoomsButton.titleLabel?.textColor = UIColor(red: 196.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1)
        self.availableRoomsButton.titleLabel?.textColor = UIColor.white
        //filtered data of available rooms from list of all meeting rooms api
        let filtered = self.listOfMeetingRooms.filter { $0.isOccupied == false }
        avaiableRoomList = filtered
        //fetching locally saved booked rooms details from user defaults
        if let data = UserDefaults.standard.data(forKey: ListViewController.AVAILABLE_ROOMS_SAVED_LOCALLY) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let locallySavedAvailableRooms = try decoder.decode([MeettingRooms].self, from: data)
                avaiableRoomList.append(contentsOf: locallySavedAvailableRooms)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
                self.listTableView.reloadData()
            activityIndicator.stopAnimating()
        }
        
        if let data = UserDefaults.standard.data(forKey: ListViewController.BOOKED_ROOMS_SAVED_LOCALLY) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let locallySavedBookedRooms = try decoder.decode([MeettingRooms].self, from: data)
                for  object in locallySavedBookedRooms{
                    
                    let searchedID = object.id
                    for i  in  0..<avaiableRoomList.count-1
                    {
                        let dict = avaiableRoomList[i]
                        let availableID = dict.id
                        if searchedID == availableID
                        {
                            avaiableRoomList .remove(at: i)
                        }
                    }
                }
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
       self.listTableView.reloadData()
        activityIndicator.stopAnimating()
    }
}
func removeDuplicates(array: [MeettingRooms]) -> [MeettingRooms] {
    var encountered = Set<MeettingRooms>()
    var result: [MeettingRooms] = []
    for value in array {
        if encountered.contains(value){
            // Do not add a duplicate element.
        }
        else {
            // Add value to the set.
            encountered.insert(value)
            // ... Append the value.
            result.append(value)
        }
    }
    return result
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categorySelected == ListViewController.PEOPLE{
        return  listOfEmployee.count
        }
        else if categorySelected == ListViewController.MEETING_ROOMS
        {
            
            if selectedRoomCategory == ListViewController.AVAILABLE_ROOMS
            {
                let noDuplicateAray = removeDuplicates(array: avaiableRoomList)
                return noDuplicateAray.count
            }
            else if selectedRoomCategory == ListViewController.BOOKED_ROOMS
            {
                let noDuplicateAray = removeDuplicates(array: bookedRoomList)
                return noDuplicateAray.count

            }
            return  listOfMeetingRooms.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell") as! CustomTableCell
        if categorySelected == ListViewController.PEOPLE{
            cell.set(track: listOfEmployee[indexPath.row])
            
            let fullName = "\(String(describing: listOfEmployee[indexPath.row].firstName)) \(String(describing: listOfEmployee[indexPath.row].lastName))"
            
            cell.nameLabel.text = fullName
        }
        else if categorySelected == ListViewController.MEETING_ROOMS
        {
            cell.profileImageView.image = UIImage(named: "MeetingImage.png")
            if selectedRoomCategory == ListViewController.AVAILABLE_ROOMS
            {
                if let meetingId = avaiableRoomList[indexPath.row].id
                {
                    cell.nameLabel.text = "Meeting Room: \(meetingId)"
                }
            }
            else if selectedRoomCategory == ListViewController.BOOKED_ROOMS
            {
                if let meetingId = bookedRoomList[indexPath.row].id
                {
                    cell.nameLabel.text = "Meeting Room: \(meetingId)"
                }
            }
            else
            {
                if let meetingId = listOfMeetingRooms[indexPath.row].id
                {
                    cell.nameLabel.text = "Meeting Room: \(meetingId)"
                }
            }
        }
        
        cell.selectionStyle = .none
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! CustomTableCell

       let detailView = self.storyboard?.instantiateViewController(withIdentifier: "DetaillInformationViewController") as! DetaillInformationViewController
        detailView.listOfMeetingRooms = listOfMeetingRooms
        if categorySelected == ListViewController.MEETING_ROOMS
        {
            detailView.categorySelected = ListViewController.MEETING_ROOMS
            detailView.trackDetailedImage = UIImage(named: "MeetingImage.png")!

            if selectedRoomCategory == ListViewController.AVAILABLE_ROOMS
            {
                detailView.meetingRoomDeatils = avaiableRoomList[indexPath.row]
                detailView.flagForlocallySavedBookedRooms = "false"

               
            }
            else if selectedRoomCategory == ListViewController.BOOKED_ROOMS
            {
                detailView.meetingRoomDeatils = bookedRoomList[indexPath.row]
                detailView.flagForlocallySavedBookedRooms = "true"
            }
            else
            {
                detailView.meetingRoomDeatils = listOfMeetingRooms[indexPath.row]
            }
        }
        else if categorySelected == ListViewController.PEOPLE
        {
            detailView.employeeDetails = listOfEmployee[indexPath.row]
            detailView.categorySelected = ListViewController.PEOPLE

            if let profileImage = currentCell.profileImageView.image
            {
                detailView.trackDetailedImage = profileImage
            }
        }
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

