//
//  MeetingRoomViewModel.swift
//  TheDirectoryApp
//
//  Created by Manju Kiran on 12/10/2022.
//

import UIKit

protocol ListViewModel {
    init(serviceManager: WebServiceManaging)
    
    var count: Int { get }
    var listDisplaying: ListDisplaying? { get set }
    func refreshData()
    func configureCell(cell: ConfigurableCell, indexPath: IndexPath)
}

protocol CellConfigurableModel {}

protocol ListDisplaying: AnyObject {
    func refreshList()
}

protocol ConfigurableCell: UITableViewCell {
    func configure(with model: CellConfigurableModel)
}
