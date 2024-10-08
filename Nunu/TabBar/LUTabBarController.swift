//
//  LUTabBarController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import UIKit
import SnapKit

class LUTabBarController: UITabBarController {

    lazy var customTabbar: CustomTabBar = {
        let bar = CustomTabBar()
        return bar
    }()
    
    let tabbarItemVC: [LUTabBarItem] = [.home, .message, .mine]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        view.addSubview(customTabbar)
        customTabbar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(31.scale)
            make.bottom.equalToSuperview().inset(30.scale + LUConstant.DSafeDistanceBottom())
            make.height.equalTo(55.scale)
        }
        
        tabbarItemVC.forEach {[weak self] item in
            guard let self = self else {return}
            self.addChild(item.tabbarItemVC)
        }
        
        customTabbar.selectBlock = {[weak self] type in
            guard let self = self else {return}
            switch type {
            case .home:
                self.selectedIndex = 0
            case .message:
                self.selectedIndex = 1
            case .mine:
                self.selectedIndex = 2
            }
        }
        // Do any additional setup after loading the view.
    }
    
    

}
