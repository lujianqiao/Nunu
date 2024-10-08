//
//  MineViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import UIKit
import SnapKit

class MineViewController: UIViewController {

    lazy var mineView: MineContentView = {
        let view = MineContentView.view()
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mineView.loadAvatar()
        getUserInfo()
    }
    
    func setUpUI() {
        view.backgroundColor = .main
        view.addSubview(mineView)
        mineView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(LUConstant.DNavigationFullHeight())
        }
        
        mineView.userInfoBlock = { [weak self] in
            guard let self = self else {return}
            if let tabbar = self.tabBarController as? LUTabBarController {
                tabbar.customTabbar.isHidden = true
            }
            let vc = ImproveInfoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        mineView.bottonItemClickBlock = {[weak self] index in
            guard let self = self else { return }
            switch index {
            case 0:
                if let tabbar = self.tabBarController as? LUTabBarController {
                    tabbar.customTabbar.isHidden = true
                }
                let vc = ComplaintViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = AgreementViewController()
                vc.type = .agree
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            case 2:
                let vc = AgreementViewController()
                vc.type = .exit
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            case 3:
                let vc = AgreementViewController()
                vc.type = .logOff
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            default:
                return
            }
        }

    }

    func getUserInfo() {
        mineView.reloadUserInfo(with: UserInfoModel.share)
        
        
//        httpProvider.request(.getUserInfo) { result in
//
//            switch result {
//            case .success(let response):
//                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
//                guard let data = json["data"] as? [String: Any] else {return}
//                print("")
//
//
//
//            case .failure(let _):
//                LUHUD.showText(text: "Data anomalies")
//            }
//
//        }
    }
    
}
