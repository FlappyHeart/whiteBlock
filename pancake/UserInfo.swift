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
    
    var userDefault = UserDefaults.standard
    
    var removeAd = false
    
    init(){
        removeAd = userDefault.bool(forKey: "removeAd")
    }
    
    func removeAdver(){
        removeAd = true
        userDefault.set(removeAd, forKey: "removeAd")
        userDefault.synchronize()
    }
    
}
