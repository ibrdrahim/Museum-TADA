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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == username{
            viewModel.updateUsername(username: newString)
        }else if textField == password{
            viewModel.updatePassword(password: newString)
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
