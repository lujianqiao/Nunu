//
//  UserInfoModel.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/21.
//

import Foundation
import UIKit

class UserInfoModel {
    
    static let share = UserInfoModel()
    
    /// 头像
    var userAvatar: UIImage? = UIImage(named: "default_avatar")
    /// 用户名
    var userName: String?
    /// 性别 -1未知，0女，1男
    var userGender: Int?
    
}
