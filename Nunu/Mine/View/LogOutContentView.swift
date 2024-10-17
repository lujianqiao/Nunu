//
//  LogOutContentView.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/4.
//

import UIKit

class LogOutContentView: UIView {
    
    private var type: AgreementViewControllerType?
    
    var closeBlock:(() -> Void)?
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var bottonBtn: UIButton!
    static func view() -> LogOutContentView {
        let view = Bundle.main.loadNibNamed(String(describing: LogOutContentView.self), owner: nil, options: nil)?.first as! LogOutContentView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topBtn.layer.cornerRadius = 10
        bottonBtn.layer.cornerRadius = 10
        bottonBtn.layer.borderColor = UIColor.init(red: 255, green: 69, blue: 157, alpha: 1).cgColor
        bottonBtn.layer.borderWidth = 1
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        if let block = closeBlock {
            block()
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        if let block = closeBlock {
            block()
        }
    }
    
    @IBAction func bottonBtnAction(_ sender: Any) {
        LUConstant.setUserDefaultsData(with: nil, key: LUConstant.userTokenKey)
        let delegate = LUConstant.getSceneDelegate()
        delegate?.window?.rootViewController = LogInViewController()
        
        if type == .logOff {
            LUConstant.resetUUID()
            LUConstant.setUserDefaultsValue(with: nil, key: LUConstant.userAvatarKey)
        }
    }
    
    
    
    
    func setType(type: AgreementViewControllerType) {
        self.type = type
        if type == .exit {
            titleLab.text = "Are you sure to log out?"
            bottonBtn.setTitle("log out", for: .normal)
        } else if type == .logOff {
            titleLab.text = "Are you sure to cancel this account?"
            bottonBtn.setTitle("log off", for: .normal)
        }
    }

}
