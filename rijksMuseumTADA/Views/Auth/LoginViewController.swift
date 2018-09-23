//
//  LoginViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let viewModel = UserViewModel()
    
    @IBAction func onLoginTap(_ sender: Any) {
        switch viewModel.validate() {
        case .Valid:
            viewModel.login { (errMsg) in
                if errMsg == nil{
                    self.performSegue(withIdentifier: "login", sender: nil)
                }else{
                    self.showConfirmAlert(title: "", message: errMsg!, callback: nil)
                }
            }
        case let .Invalid(msg):
            self.showConfirmAlert(title: "", message: msg, callback: nil)
        }
    }
    
    @IBAction func onRegisterTap(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview!.viewWithTag(nextTag) as UIResponder?
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField == username{
            viewModel.updateUsername(username: textField.text!)
        }else if textField == password{
            viewModel.updatePassword(password: textField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

}
