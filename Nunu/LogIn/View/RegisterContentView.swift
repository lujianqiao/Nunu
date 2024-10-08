//
//  RegisterContentView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/5.
//

import UIKit

class RegisterContentView: UIView {

    var nextStepBlock:((_ account: String, _ pw: String, _ confirmPw: String) -> Void)?
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var pwField: UITextField!
    
    @IBOutlet weak var confirmPw: UITextField!
    
    
    @IBOutlet weak var nextStepBtn: UIButton!
    static func view() -> RegisterContentView {
        let view = Bundle.main.loadNibNamed(String(describing: RegisterContentView.self), owner: nil, options: nil)?.first as! RegisterContentView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextStepBtn.layer.cornerRadius = 10
        nextStepBtn.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
    }

    @objc func nextStepBtnAction() {
        
        let account = accountField.text
        let pw = pwField.text
        let confirmPw = confirmPw.text
        
        guard account?.count ?? 0 > 0 else {
            LUHUD.showText(text: "Please enter your email address")
            return
        }
        
        guard pw?.count ?? 0 > 0 else {
            LUHUD.showText(text: "Please creat your password")
            return
        }
        
        guard confirmPw?.count ?? 0 > 0 else {
            LUHUD.showText(text: "Please enter your password again")
            return
        }
        
        guard confirmPw == pw else {
            LUHUD.showText(text: "Please enter your password again")
            return
        }
        
        guard let block = nextStepBlock else {return}
        block(account!, pw!, confirmPw!)
    }
    
}
