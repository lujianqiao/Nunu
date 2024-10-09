//
//  PayConfigModel.swift
//  Nunu
//
//  Created by lujianqiao on 2024/10/9.
//

import Foundation
import HandyJSON

struct PayConfigModel: HandyJSON {
    /// id
    var id: Int = 0
    /// 对应苹果的订阅id
    var pid: String = ""
    /// 钻石金币
    var chips: Int = 0
    /// 需要美刀
    var money: Double = 0
    /// 赠送的
    var presentation: Int = 0
    /// 选择
    var selected: Bool = false
}
