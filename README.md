# DirectoryApp_2709

App is built using MVVM Design Pattern

App is developed using Swift and Xcode.

This is universal app and deployment target is supported for iOS 15.2

Image caching is used to load images faster after downloading it once.

Scrollview is used on detail list information page to have better view on smaller screen size devices and also to add on some more details in future.

Model : Codables structs are used

Added unit test for employee list api using mock data (data.json file in bundle)

Dependency injections are used for unit testing App Flow :

App opens with a launch screen

The First view (ViewController.swift) has two button a.Firm Directory -> Takes us to list of firm employees b.Meeting Rooms -> Shows booked and available meeting rooms

Second View (ListViewController.swift) shows list depending upon the category selected: a. List of employees : Name and Photo of employee is displayed b. Booked and Available Rooms List : Meeting room with ID’s are displayed on list.Default image is loaded on list.

Third View (DetailInformationView. Swift) All the information about the selected category ,be it employee or booked room or available room is displayed on a scrollview. a. A meeting can be booked ,if an available room is selected from the List by using “Book a meeting” button in end of the page. b. If Room is already booked ,“Release Meeting Room” button is seen on page. c. Once room is booked, the room moves from available room to booked room. d. Once room is released, the room moves from booked room to available room.
