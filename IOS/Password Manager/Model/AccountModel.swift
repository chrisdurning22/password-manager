//
//  HomeModel.swift
//  Password Manager
//
//  Created by Chris Durning on 04/10/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import Foundation

class AccountModel: NSObject {
    var userName: String?
    var accountType: String?
    var accountPassword: String?
    
    override init() {
        
    }
    
    init(userName: String, accountType: String, accountPassword: String) {
        self.userName = userName
        self.accountType = accountType
        self.accountPassword = accountPassword
    }
    
    override var description: String {
        return "username: \(String(describing: userName)), account: \(String(describing: accountType)), accPassword: \(String(describing: accountPassword))"
    }
    
}
