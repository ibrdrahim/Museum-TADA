//
//  MuseumCollectionViewCell.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit

class MuseumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var museumImage: UIImageView!
    @IBOutlet weak var museumTitle: UILabel!
    var museum: MuseumViewModel.MuseumCollectionViewCellData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        // Initialization code
    }

}
