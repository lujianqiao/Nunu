//
//  RegisterViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/5.
//

import UIKit

class RegisterViewController: UIViewController {

    lazy var registerView: RegisterContentView = {
        let view = RegisterContentView.view()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem.init(image: .init(named: "nav_back"), style: .plain, target: self, action: #selector(deleteAction))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
        
        title = "Email registration"
        
        view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(LUConstant.DNavigationFullHeight())
        }
        
        registerView.nextStepBlock = { [weak self] account, pw, _ in
            guard let self = self else {return}
            self.registerAction(account: account, pw: pw)
        }
        
        // Do any additional setup after loading the view.
    }

    
    func registerAction(account: String, pw: String) {
        httpProvider.request(.register(account, pw)) { result in
            
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [String: Any] else {return}
                guard let access_token = data["access_token"] as? String else {return}
                LUConstant.setUserDefaultsData(with: access_token, key: LUConstant.userTokenKey)
                let vc = ImproveInfoViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let _):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
    }
    
    @objc func deleteAction() {
        dismiss(animated: true)
    }
}

