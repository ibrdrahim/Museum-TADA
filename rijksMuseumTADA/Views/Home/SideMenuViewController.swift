//
//  SideMenuViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        SideMenuManager.default.menuLeftNavigationController = settingsStoryboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuLeftNavigationController?.menuWidth = view.frame.width * 0.85
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onHamburgerTap(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

}
