//
//  TestModel.swift
//  Password Manager
//
//  Created by Chris Durning on 04/10/2018.
//  Copyright © 2018 Chris Durning. All rights reserved.
//

import Foundation


protocol ServerModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class ServerModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: ServerModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://178.128.38.155/service.php" //this will be changed to the path where service.php lives
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
                
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let homes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let home = HomeModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let username = jsonElement["userName"] as? String,
                let password = jsonElement["userPassword"] as? String
            {
    
                home.userName = username
                home.userPassword = password
                
            }
            
            homes.add(home)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: homes)
            
        })
    }

}
