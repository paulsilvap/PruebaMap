//
//  HomeModel.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/11/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HomeModel{
    
    // MARK: -
    // MARK: functions
    
    func getOrders(urlPath: String, completionHandler: (JSON, NSError?) -> ()) {
        download(urlPath, completionHandler: completionHandler)
    }
    
    func download(urlPath: String, completionHandler: (JSON, NSError?) -> ()) {
        Alamofire.request(.GET, urlPath).validate().responseJSON { response in
            guard response.result.error == nil else {
                completionHandler(nil, response.result.error)
                print(response.result.error!)
                return
            }
            guard let value = response.result.value else {
                print("no se recibio información")
                return
            }
            completionHandler(JSON(value), nil)
        }
    }
}