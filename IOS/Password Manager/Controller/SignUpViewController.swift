//
//  SignUpViewController.swift
//  Password Manager
//
//  Created by Chris Durning on 05/10/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    @IBOutlet weak var signalLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func doPasswordsMatch(pass:String, confirmPass:String) -> Bool {
        return pass == confirmPass
    }
    
    @IBAction func pressSignUp(_ sender: Any) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = rePasswordTextField.text else { return }
        
        if(isFormatCorrect(email: email, pass: password, conf: confirmPassword)) {
            let postString = "&a=\(email)&b=\(password)"
            
            guard let url = URL(string: "http://178.62.107.63/insert.php") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
            }.resume()
        }
    }
    
    func isFormatCorrect(email:String, pass:String, conf: String) -> Bool {
        self.signalLabel.text = ""
        
        if(!isValidEmail(testStr: email)) {
            self.signalLabel.text = "The email address that you've entered is not valid. Please enter a valid email address.";
            return false;
        }
        else if (!doPasswordsMatch(pass: pass, confirmPass: conf)) {
            self.signalLabel.text = "The passwords you've entered do not match.";
            return false;
        }
        return true;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
