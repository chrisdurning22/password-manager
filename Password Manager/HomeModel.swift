//
//  HomeModel.swift
//  Password Manager
//
//  Created by Chris Durning on 04/10/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import Foundation

class HomeModel: NSObject {
    var userName: String?
    var userPassword: String?
    
    override init() {
        
    }
    
    init(userName: String, userPassword: String) {
        self.userName = userName
        self.userPassword = userPassword
    }
    
    override var description: String {
        return "username: \(String(describing: userName)), password: \(String(describing: userPassword))"
    }
    
}
