//
//  CustomTableCell.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 27/07/22.
//

import Foundation
import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
 
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: set function to set the image to imageview
       func set(track: Employee) {
           ImageCacheService.getImage(withURL: track.avatar!) { image in
            if (image != nil) {
               self.profileImageView.image = image
            }
           }
       }
}
