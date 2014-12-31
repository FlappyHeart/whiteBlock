//
//  UserInfo.swift
//  foggyhorse
//
//  Created by Alfred on 14/11/12.
//  Copyright (c) 2014年 HackSpace. All rights reserved.
//

import SpriteKit

var globalUserData = UserInfo()

class UserInfo{
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    var removeAd = false
    
    init(){
        removeAd = userDefault.boolForKey("removeAd")
    }
    
    func removeAdver(){
        removeAd = true
        userDefault.setBool(removeAd, forKey: "removeAd")
        userDefault.synchronize()
    }
    
}
