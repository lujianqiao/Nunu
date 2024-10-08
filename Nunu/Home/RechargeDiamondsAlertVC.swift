//
//  RechargeDiamondsAlertVC.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/8.
//

import UIKit

class RechargeDiamondsAlertVC: UIViewController {

    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bgViewTap))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var needRecharge: NeedRechargeDiamondsView = {
        let view = NeedRechargeDiamondsView.view()
        return view
    }()
    
    lazy var diamondsView: RechargeDiamondsDetailView = {
        let view = RechargeDiamondsDetailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    

    func setUpUI() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        view.addSubview(needRecharge)
//        needRecharge.snp.makeConstraints { make in
//            make.left.bottom.right.equalToSuperview()
//            make.height.equalTo(342)
//        }
//        
//        needRecharge.deleteBlock = { [weak self] in
//            guard let self = self else {return}
//            self.dismiss(animated: true)
//        }
        
        view.addSubview(diamondsView)
        diamondsView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(LUConstant.kScreenHeight - 118)
        }
    }
    
    @objc func bgViewTap() {
        self.dismiss(animated: true)
    }
    
}
