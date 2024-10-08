//
//  LUHUD.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/9.
//

import Foundation
import MBProgressHUD

struct LUHUD {
    
    static func showText(text: String, showView: UIView = LUConstant.keyWindow()) {
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.offset = CGPoint(x: 0.0, y: 1000000.0)
        hud.hide(animated: true, afterDelay: 2)
    }
    
    static func showHUD(showView: UIView = LUConstant.keyWindow()) -> MBProgressHUD {
        let window = LUConstant.keyWindow()
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        return hud
    }
    
}
