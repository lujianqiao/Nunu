//
//  HomeViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import UIKit
import JXBanner

class HomeViewController: UIViewController {

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
    
    private var currentIndex: Int = 0
    
    lazy var linearBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "linearBanner"
        banner.delegate = self
        banner.dataSource = self
        return banner
        }()
    
    
    lazy var bgImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "home_bg"))
        return image
    }()
    
    lazy var sendMessageBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "home_send_message"), for: .normal)
        btn.addTarget(self, action: #selector(sendMessageBtnAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func setUpUI() {
        view.addSubview(bgImage)
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(linearBanner)
        linearBanner.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(80.scale)
            make.bottom.equalToSuperview().inset(190.scale)
        }
        
        view.addSubview(sendMessageBtn)
        sendMessageBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13)
            make.bottom.equalToSuperview().inset(90.scale + LUConstant.DSafeDistanceBottom())
        }
    }
    
    @objc func sendMessageBtnAction() {
        
        if let tabbar = self.tabBarController as? LUTabBarController {
            tabbar.customTabbar.isHidden = true
        }
        let data = datas[currentIndex]
        let vc = ChatViewController()
        vc.chatID = data
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let vc = RechargeDiamondsAlertVC()
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
    }
    
}

//MARK:- JXBannerDataSource
extension HomeViewController: JXBannerDataSource {
    
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
                .itemSize(CGSize(width: 320.scale, height: 490.scale))
                .itemSpacing(10)
                .minimumAlpha(0.8)
            
    }
    
    
}

//MARK:- JXBannerDelegate
extension HomeViewController: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        currentIndex = index
        print(index)
    }
}
