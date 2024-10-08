//
//  LUImage+Ex.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/15.
//

import Foundation
import UIKit

enum ImageCopmpressSize {
    //压缩到100KB(1024*100字节)以内
    case one
    //压缩到200KB(1024*100字节)以内
    case two
    //压缩到300KB(1024*100字节)以内
    case three
}


extension UIImage {
    
    //我们的项目就定不大于200KB
    func compressImage() -> Data{
        compressImage(size: .two)
    }
    
    
    func compressImage(size:ImageCopmpressSize) -> Data{
        switch size {
        case .one:
            return compressImage(maxLength: 1024*100)
        case .two:
            return compressImage(maxLength: 1024*200)
        case .three:
            return compressImage(maxLength: 1024*300)
        default:
            break
        }
    }
    
    
    // 图片压缩 byte
        func compressImage(maxLength: Int) -> Data {
            // let tempMaxLength: Int = maxLength / 8
            let tempMaxLength: Int = maxLength
            var compression: CGFloat = 1
            guard var data = self.jpegData(compressionQuality: compression), data.count > tempMaxLength else { return self.jpegData(compressionQuality: compression)! }
            
            // 压缩大小
            var max: CGFloat = 1
            var min: CGFloat = 0
            for _ in 0..<6 {
                compression = (max + min) / 2
                data = self.jpegData(compressionQuality: compression)!
                if CGFloat(data.count) < CGFloat(tempMaxLength) * 0.9 {
                    min = compression
                } else if data.count > tempMaxLength {
                    max = compression
                } else {
                    break
                }
            }
            var resultImage: UIImage = UIImage(data: data)!
            if data.count < tempMaxLength { return data }
            
            // 压缩大小
            var lastDataLength: Int = 0
            while data.count > tempMaxLength && data.count != lastDataLength {
                lastDataLength = data.count
                let ratio: CGFloat = CGFloat(tempMaxLength) / CGFloat(data.count)
                print("Ratio =", ratio)
                let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                          height: Int(resultImage.size.height * sqrt(ratio)))
                UIGraphicsBeginImageContext(size)
                resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                resultImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                data = resultImage.jpegData(compressionQuality: compression)!
            }
            return data
        }

}

