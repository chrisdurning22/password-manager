//
//  ViewController.swift
//  Password Manager
//
//  Created by Chris Durning on 25/09/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {
    
    let ACCOUNT_CONFIRMATION_URL = "http://178.62.107.63/account_confirmation.php"
    
    var accounts = NSMutableArray()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor( red: 0.1, green: 0.5, blue:0.2, alpha: 1.0 ).cgColor
        logInButton.layer.backgroundColor = UIColor( red: 0.4, green: 0.8, blue:0.6, alpha: 1.0 ).cgColor
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: Actions
    @IBAction func logInButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        getAccountData(url: ACCOUNT_CONFIRMATION_URL, email: email, pass: password)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAccountView" {
            let destAccountVC = segue.destination as! AccountViewController
            destAccountVC.accounts = self.accounts
        }
    }
    
    //MARK: - Netowrking
    /***********************************************************************************************/
 
    func getAccountData(url: String, email: String, pass: String) {
        let parameters: Parameters = [
            "user": email,
            "pass": pass
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success!")
                
                let accountJSON : JSON = JSON(response.result.value!)
                self.parseJSON(accountJSON)
                self.performSegue(withIdentifier: "goToAccountView", sender: self)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                
            }
        }
    }
    
    //MARK: - Parsing JSON
    /***********************************************************************************************/
    func parseJSON(_ json:JSON) {
    
        for (_, subJson):(String, JSON) in json {
            let account = AccountModel();
            account.userName = subJson["userName"].stringValue
            account.accountType = subJson["accountType"].stringValue
            account.accountPassword = subJson["accountPassword"].stringValue
            
            accounts.add(account)
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        //emailNameLabel.text = textField.text
    }
}

