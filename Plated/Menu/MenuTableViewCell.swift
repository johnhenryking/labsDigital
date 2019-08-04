//
//  MenuTableViewCell.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    var recipe: Recipe? {
        didSet {
            self.updateUI()
        }
    }
    
    fileprivate func updateUI() {
        
        self.textLabel?.text = recipe?.name
        self.detailTextLabel?.text = recipe?.descriptor
        guard let imageUrl = recipe?.image  else { return }
        self.imageView?.setImage(with: imageUrl)
        
    }

}
