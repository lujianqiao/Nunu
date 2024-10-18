//
//  RechargeDiamondsAlertVC.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/8.
//

import UIKit

class RechargeDiamondsAlertVC: UIViewController {

    var datas: [PayConfigModel] = []
    var paySuccessBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bgViewTap))
        view.addGestureRecognizer(tap)
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
        
        diamondsView.datas = datas
        
        diamondsView.deleteBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        diamondsView.rechargeBlock = {[weak self] model in
            guard let self = self else { return }
            // TODO: -充值
            let hud = LUHUD.showHUD(showView: self.view)
            STIAPManager.shared.pay(productId: model.pid) { productId, receipt, transaction in
                hud.hide(animated: true)
                
                // 拿到购买凭证
                guard let transactionIdentifier = transaction.transactionIdentifier else {return}
                httpProvider.request(.verifyPurchaseProof(productId, receipt, transactionIdentifier, 2)) { result in
                   
                    switch result {
                    case .success(let response):
                        guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                        guard let code = json["code"] as? Int else {return}
                        if code == 1 {
                            // 验证通过
                            LUHUD.showText(text: "Purchase Success", showView: self.view)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                
                                self.dismiss(animated: true)
                                if let block = self.paySuccessBlock {
                                    block()
                                }
                                
                            }
                            
                        }
                    case .failure(_):
                        LUHUD.showText(text: "Data anomalies")
                    }
                    
                }
                
                debugPrint("receipt")
            } failed: { error in
                hud.hide(animated: true)
                debugPrint(error)
            } canceled: {
                hud.hide(animated: true)
                debugPrint("cancel")
            }

            
        }
    }
    
    @objc func bgViewTap() {
        self.dismiss(animated: true)
    }
    
}
