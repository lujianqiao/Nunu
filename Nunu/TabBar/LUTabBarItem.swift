//
//  LUTabBarItem.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import Foundation
import UIKit

enum LUTabBarItem {
    case home
    case message
    case mine
}

extension LUTabBarItem {
    
    var tabbarItemVC: LUNavigationController {
        
        switch self {
        case .home:
            let vc = HomeViewController()
            return LUNavigationController(rootViewController: vc)
        case .message:
            let vc = MessageViewController()
            return LUNavigationController(rootViewController: vc)
        case .mine:
            let vc = MineViewController()
            return LUNavigationController(rootViewController: vc)
        
        }
        
    }
}
