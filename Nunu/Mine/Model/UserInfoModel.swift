//
//  UserInfoModel.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/21.
//

import Foundation
import UIKit
import SmartCodable

class UserInfoManager {
    
    static let share = UserInfoManager()
    
    var userInfo: UserInfoModel = UserInfoModel()
    
}


struct UserInfoModel: SmartCodable {
    
    /// 头像
    var userAvatar: Data? = Data()
    /// 用户名
    var nick_name: String? = ""
    /// 性别 -1未知，0女，1男
    var userGender: Int? = -1
    /// 金币
    var chips: Int = 0
    
//    required init()
    
}
