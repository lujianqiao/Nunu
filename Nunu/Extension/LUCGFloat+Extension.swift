//
//  LUCGFloat+Extension.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import Foundation

extension CGFloat {
    var scale: CGFloat {
        return self * CGFloat(LUConstant.kScreenWidth) / CGFloat(375)
    }
}
