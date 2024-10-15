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
        
        mineView.beanBGViewClickBlock = { [weak self] in
            guard let self = self else { return }
            
            self.getRechargeList()
            
        }

    }

}

extension MineViewController {
    func getUserInfo() {
        
        httpProvider.request(.getUserInfo) { result in

            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [String: Any] else {return}
                guard let model = UserInfoModel.deserialize(from: data) else {return}
                UserInfoManager.share.userInfo = model
                self.mineView.reloadUserInfo(with: UserInfoManager.share.userInfo)
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }

        }
    }
    
    func getRechargeList() {
        
        let hud = LUHUD.showHUD()
        httpProvider.request(.payConfigList) { result in

            hud.hide(animated: true)
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [Any] else {return}
                guard let models = [PayConfigModel].deserialize(from: data) else {return}
                let datas = models
                
                let vc = RechargeDiamondsAlertVC()
                vc.modalPresentationStyle = .overFullScreen
                vc.datas = datas
                self.present(vc, animated: true)
                vc.paySuccessBlock = { [weak self] in
                    guard let self = self else { return }
                    self.getUserInfo()
                }
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
        
    }
}
