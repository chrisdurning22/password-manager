//
//  ViewController.swift
//  Password Manager
//
//  Created by Chris Durning on 25/09/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ServerModelProtocol {
    
    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailNameLabel: UILabel!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    var feedItems: NSArray = NSArray()
    var selectedHomeItems : HomeModel = HomeModel()
    var x = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor( red: 0.1, green: 0.5, blue:0.2, alpha: 1.0 ).cgColor
        
        logInButton.layer.backgroundColor = UIColor( red: 0.4, green: 0.8, blue:0.6, alpha: 1.0 ).cgColor
        
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.lightGray.cgColor
        
        
        // Do any additional setup after loading the view, typically from a nib.
        emailTextField.delegate = self
        
        let testModel = ServerModel()
        testModel.delegate = self
        testModel.downloadItems()
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        let item: HomeModel = feedItems[0] as! HomeModel
        x.self = item
    
    }
    
    //MARK: Actions
    @IBAction func logInButton(_ sender: UIButton) {
        //self.emailNameLabel.text = x.userName
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

