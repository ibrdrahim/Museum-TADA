//
//  SideMenuTableViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import SideMenu

class SideMenuTableViewController: UITableViewController {
    let accentColor : UIColor = UIColor(red: 216/255, green: 67/255, blue: 114/255, alpha: 1)
    let fontColor : UIColor = UIColor.init(white: 1, alpha: 1)
    
    @IBOutlet weak var headerTitle: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        headerTitle.text =  "Welcome, "+UserLoginProvider.getLoginData().username
        self.tableView.backgroundColor = accentColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let labels = getAllSubviews(view: cell) as [UILabel]
        
        for label in labels{
            if (label.textColor != fontColor){
                label.textColor = fontColor
            }
        }
        cell.backgroundColor = accentColor
        let selectedViewBackground = UIView.init()
        selectedViewBackground.backgroundColor = accentColor
        cell.selectedBackgroundView = selectedViewBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        dismiss(animated: true) {
            if indexPath.item == 0{
                let vc = Storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                UIApplication.shared.keyWindow?.rootViewController = vc
            }else if indexPath.item == 1{
                let vc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                UIApplication.shared.keyWindow?.rootViewController = vc
            }
        }
    }
    
    func getAllSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(view: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }
    
}
