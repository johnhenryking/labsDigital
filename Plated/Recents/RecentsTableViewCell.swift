//
//  Cell.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

class RecentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recipeImageView: CustomImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var recipe: Recipe? {
        didSet {
            self.updateUI()
        }
    }
    
    fileprivate func updateUI() {
        
        nameLabel.text = recipe?.name
        descriptionLabel.text = recipe?.descriptor
        guard let imageUrl = recipe?.image  else { return }
        recipeImageView.loadImage(with: imageUrl)
        
    }
    
}
