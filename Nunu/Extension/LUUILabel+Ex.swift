//
//  LUUILabel+Ex.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/16.
//

import UIKit

extension UILabel {
    
    
    func labelWidth(height:CGFloat)->CGFloat{
        let dic = [NSAttributedString.Key.font : font]
        let size = CGSize(width: 0, height: height)
        let rect = text!.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: dic as [NSAttributedString.Key : Any], context: nil)
        return CGFloat(ceilf(Float(rect.size.width)))
    }
    
    func labelHeight(width:CGFloat)->CGFloat{
        let dic = [NSAttributedString.Key.font : font]
        let size = CGSize(width: width, height: 0)
        let rect = text!.boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: dic as [NSAttributedString.Key : Any], context: nil)
        return CGFloat(ceilf(Float(rect.size.height)))
    }
    
}

