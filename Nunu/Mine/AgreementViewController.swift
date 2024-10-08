//
//  AgreementViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/3.
//

import UIKit

enum AgreementViewControllerType {
    case agree
    case exit
    case logOff
}

class AgreementViewController: UIViewController {

    var type: AgreementViewControllerType = .agree {
        didSet {
            if type == .agree {
                agreeView.isHidden = false
                logoutView.isHidden = true
            } else {
                
                self.logoutView.setType(type: type)
                agreeView.isHidden = true
                logoutView.isHidden = false
            }
        }
    }
    
    lazy var BGView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0, alpha: 0.4)
        return view
    }()
    
    lazy var agreeView: AgreementContentView = {
        let view = AgreementContentView.view()
        return view
    }()
    
    lazy var logoutView: LogOutContentView = {
        let view = LogOutContentView.view()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(BGView)
        BGView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(agreeView)
        agreeView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(LUConstant.kScreenHeight - 182)
        }
        
        view.addSubview(logoutView)
        logoutView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(271)
        }
        
        
        agreeView.closeBlock = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        
        logoutView.closeBlock = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
}
