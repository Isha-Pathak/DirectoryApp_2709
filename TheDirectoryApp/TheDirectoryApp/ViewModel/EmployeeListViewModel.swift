//
//  EmployeeListViewModel.swift
//  TheDirectoryApp
//
//  Created by Manju Kiran on 12/10/2022.
//

class EmployeeListViewModel: ListViewModel, EmployeeDetailProtocol {
    
    private let serviceManager: ListWebServiceManager
    weak var listDisplaying: ListDisplaying?
    
    private var employees: Employees = Employees() {
        didSet {
            listDisplaying?.refreshList()
        }
    }

    init(serviceManager: ListWebServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func refreshData() {
        refreshEmployeeDetails()
    }
    
    private func refreshEmployeeDetails() {
        let completionHandler: (_ employees : Employees?, _ error: Error?) -> Void = { (employeeList, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let employeeList = employeeList  else { return }
            employees = employeeList
        }

        serviceManager.fetch(url: APIConstants.EndPoint.people.url,
                             completion: completionHandler)
    }
    
    var numberOfRows: Int {
        employees.count
    }
}
