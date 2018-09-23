//
//  ProfileViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit

class ProfileViewController: SideMenuViewController {

    @IBOutlet weak var username: UILabel!
    
    @IBAction func logoutDidTap(_ sender: Any) {
        UserLoginProvider.removeLoginData()
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController = initialViewController
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = UserLoginProvider.getLoginData().username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }


}
