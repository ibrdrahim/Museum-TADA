//
//  RegisterViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var agreement: CheckBox!
    
    let viewModel = UserViewModel()
    
    
    @IBAction func onRegisterTap(_ sender: Any) {
        if !agreement.isChecked{
            self.showConfirmAlert(title: "", message: "Please check Agreement first", callback: nil)
            return
        }
        
        switch viewModel.validate() {
        case .Valid:
            viewModel.register { (errMsg) in
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
