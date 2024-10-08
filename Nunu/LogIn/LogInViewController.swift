//
//  LogInViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/4.
//

import UIKit
import JXBanner


class LogInViewController: UIViewController {

    var isQuickLogon: Bool = false
    private var datas: [String] = ["message_1",
                                   "message_2",
                                   "message_3",
                                   "message_4",
                                   "message_5",
                                   "message_6",
                                   "message_7",
                                   "message_8",
                                   "message_9",
                                   "message_10",
                                   "message_11",
                                   "message_12"]
    
    
    
    lazy var loginView: LogInContentView = {
        let view = LogInContentView.view()
        if self.isQuickLogon {
            view.registerBtn.isHidden = true
            view.loginBtn.setTitle("Logon", for: .normal)
        }
        return view
    }()
    
    lazy var linearBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.addSubview(linearBanner)
        linearBanner.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(130)
            make.height.equalTo(330.scale)
        }
        
        loginView.loginBlock = { [weak self] in
            guard let self = self else {return}
            if isQuickLogon {
                self.logonAction()
            } else {
                let vc = LogInViewController()
                vc.isQuickLogon = true
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }
        
        loginView.registerBlock = { [weak self]  in
            guard let self = self else {return}
            let vc = RegisterViewController()
            let nav = LUNavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            self.present(nav, animated: true)
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func logonAction() {
        let hud = LUHUD.showHUD()
        httpProvider.request(.quickLogon) { result in

            hud.hide(animated: true)
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [String: Any] else {return}
                guard let access_token = data["access_token"] as? String else {return}
                LUConstant.setUserDefaultsData(with: access_token, key: LUConstant.userTokenKey)
                print("access_token===\(access_token)")
                let delegate = LUConstant.getSceneDelegate()
                delegate?.window?.rootViewController = LUTabBarController()
                
            case .failure(let _):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
    }
    
}


//MARK:- JXBannerDataSource
extension LogInViewController: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "LinearBannerCell")
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
    -> Int { return datas.count }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell = cell as! JXBannerCell
            let imageName = datas[index]
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: imageName)
            tempCell.imageView.contentMode = .scaleAspectFill
            tempCell.msgLabel.isHidden = true
            tempCell.msgBgView.isHidden = true
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
        -> JXBannerParams {
            
            return params
                .timeInterval(5)
                .cycleWay(.forward)
                .isShowPageControl(false)
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            
            return layoutParams
                .layoutType(JXBannerTransformLinear())
                .itemSize(CGSize(width: 250.scale, height: 300.scale))
                .itemSpacing(10)
                .minimumAlpha(0.8)
            
    }
    
    
}

//MARK:- JXBannerDelegate
extension LogInViewController: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        print(index)
    }
}
