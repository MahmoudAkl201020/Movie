//
//  HomeCollectionViewCell.swift
//  Movie
//
//  Created by Mahmoud Akl on 7/10/18.
//  Copyright © 2018 Mahmoud Akl. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    override func awakeFromNib() {
        
        cellView.layer.cornerRadius = 3
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cellView.layer.shadowRadius = 1.7
        cellView.layer.shadowOpacity = 0.3

    }
    
    
}
