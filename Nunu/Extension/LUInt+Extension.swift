//
//  LUInt+Extension.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import Foundation
import UIKit

extension Int {
    var scale: CGFloat {
        return CGFloat(self) * CGFloat(LUConstant.kScreenWidth) / CGFloat(375)
    }
}
