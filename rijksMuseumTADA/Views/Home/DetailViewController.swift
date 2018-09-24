//
//  DetailViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    var museumDesc: String?
    var imageUrl: String?
    
    @IBOutlet weak var titleMuseum: UILabel!
    @IBOutlet weak var imageMuseum: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleMuseum.text = museumDesc
        imageMuseum.sd_setImage(with: URL(string: imageUrl!), placeholderImage: #imageLiteral(resourceName: "placeholder3"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    

}
