//
//  Constant.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import Foundation
import UIKit

struct LUConstant {
    
    /// 屏幕宽度
    static let kScreenWidth = (UIScreen.main.bounds.size.width)
    /// 屏幕高度
    static let kScreenHeight = (UIScreen.main.bounds.size.height)
    
    static let userTokenKey = "userTokenKey"
    
    static let userAccountKey = "userAccountKey"
    
    static let userAvatarKey = "userAvatar"
    
    static let userChatDataKey = "userChatDataKey"
    
    /// 顶部安全距离
    static func DSafeDistanceTop() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.top
        }
        return 0;
    }
    
    /// 底部安全距离
    static func DSafeDistanceBottom() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        }
        return 0;
    }
    
    /// 状态栏高度
    static func DStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    static func DNavigationBarHeight() -> CGFloat {
        return 44.0
    }
    
    static func DNavigationFullHeight() -> CGFloat {
        return LUConstant.DStatusBarHeight() + LUConstant.DNavigationBarHeight()
    }
    static func DTabBarHeight() -> CGFloat {
        return 49.0
    }
    static func DTabBarFullHeight() -> CGFloat {
        return LUConstant.DTabBarHeight() + LUConstant.DSafeDistanceBottom()
    }
    
    // MARK: - 当前window
    static func keyWindow() -> UIWindow {
        if #available(iOS 15.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows.first ?? UIWindow()
            return keyWindow
        }else {
            let keyWindow = UIApplication.shared.windows.first ?? UIWindow()
            return keyWindow
        }
    }
    
    /// 获取UUID
    static var UUID: String {
        let uuid = Foundation.UUID().uuidString
        return uuid
    }
 
    /// 获取SceneDelegate
    static func getSceneDelegate() -> SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegate
    }
    
    
    /// 获取信息
    static func getUserDefaultsData(with key: String) -> String? {
        let auth = UserDefaults.standard.value(forKey: key) as? String
        return auth
    }
    
    
    /// 保存信息
    static func setUserDefaultsData(with data: String?, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    /// 获取数据
    static func getUserDefaultsValue(with key: String) -> Data? {
        let value = UserDefaults.standard.value(forKey: key) as? Data
        return value
    }
    
    
    /// 保存数据
    static func setUserDefaultsValue(with data: Data, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    static func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            
            print("is not a valid json object")
            
            return nil
            
        }
        
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        
        //Data转换成String打印输出
        
        let str = String(data:data!, encoding: String.Encoding.utf8)
        
        //输出json字符串
        
        print("Json Str:\(str!)")
        
        return data
        
    }
    
    static func dataToDictionary(data:Data) -> Dictionary<String, Any>?{

        do{

            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

            let dic = json as! Dictionary<String, Any>

            return dic

        }catch _ {

            print("失败")

            return nil

        }

    }
    
}
