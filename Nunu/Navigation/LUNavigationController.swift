//
//  LUNavigationController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import UIKit

class LUNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIStyle()
        // Do any additional setup after loading the view.
    }

    func setUIStyle() {
        // 创建导航栏外观
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.main // 设置背景颜色
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // 应用外观到导航栏
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 1 {
            
            if let tabbar = self.tabBarController as? LUTabBarController {
                tabbar.customTabbar.isHidden = true
            }
            
        }
        
        if viewControllers.count > 0 {
            let backBtn = UIBarButtonItem.init(image: .init(named: "nav_back"), style: .plain, target: self, action: #selector(deleteAction))
            backBtn.tintColor = .white
            viewController.navigationItem.leftBarButtonItem = backBtn
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        
        if viewControllers.count <= 2 {
            
            if let tabbar = self.tabBarController as? LUTabBarController {
                tabbar.customTabbar.isHidden = false
            }
            
        }
        return super.popViewController(animated: animated)
    }
    
    @objc func deleteAction() {
        popViewController(animated: true)
    }
}




