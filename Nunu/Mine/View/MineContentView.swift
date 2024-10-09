//
//  AAA.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/2.
//

import UIKit

class MineContentView: UIView {

    var userInfoBlock:(() -> Void)?
    var bottonItemClickBlock: ((Int) -> Void)?
    var beanBGViewClickBlock: (() -> Void)?
    
    /// 头像
    @IBOutlet weak var avatarBtn: UIButton!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var beanBGView: UIView!
    
    @IBOutlet weak var beanLab: UILabel!
    
    
    @IBOutlet weak var complaint: UIView!
    
    @IBOutlet weak var agreement: UIView!
    
    @IBOutlet weak var exit: UIView!
    
    @IBOutlet weak var logOff: UIView!
    
    static func view() -> MineContentView {
        let view = Bundle.main.loadNibNamed(String(describing: MineContentView.self), owner: nil, options: nil)?.first as! MineContentView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        complaint.layer.cornerRadius = 10
        agreement.layer.cornerRadius = 10
        exit.layer.cornerRadius = 10
        logOff.layer.cornerRadius = 10
        avatarBtn.clipsToBounds = true
        avatarBtn.layer.cornerRadius = 51
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(nameAction))
        nameLab.isUserInteractionEnabled = true
        nameLab.addGestureRecognizer(tap)
        
        beanBGView.layer.cornerRadius = 10
        let beanBGViewTap = UITapGestureRecognizer(target: self, action: #selector(beanBGViewTap))
        beanBGView.addGestureRecognizer(beanBGViewTap)
    }
    
    func loadAvatar() {
        
        if let _ = LUConstant.getUserDefaultsData(with: LUConstant.userTokenKey) {
            guard let imageData = LUConstant.getUserDefaultsValue(with: LUConstant.userAvatarKey) else {return}
            avatarBtn.setImage(UIImage(data: imageData), for: .normal)
        }
    }

    @objc func nameAction() {
        if let block = userInfoBlock {
            block()
        }
    }
    
    
    @objc func beanBGViewTap() {
        if let block = beanBGViewClickBlock {
            block()
        }
    }
    
    @IBAction func userInfoAction(_ sender: Any) {
        if let block = userInfoBlock {
            block()
        }
    }
    
    @IBAction func complaintAction(_ sender: Any) {
        if let block = bottonItemClickBlock {
            block(0)
        }
    }
    
    @IBAction func agreementAction(_ sender: Any) {
        if let block = bottonItemClickBlock {
            block(1)
        }
    }
    
    @IBAction func exitAction(_ sender: Any) {
        if let block = bottonItemClickBlock {
            block(2)
        }
    }
    
    @IBAction func logOffAction(_ sender: Any) {
        if let block = bottonItemClickBlock {
            block(3)
        }
    }
    
    
    func reloadUserInfo(with userInfo: UserInfoModel) {
        if let avatar = userInfo.userAvatar {
            avatarBtn.setImage( avatar, for: .normal)
        }
        if let name = userInfo.userName {
            nameLab.text = name
        }
    }
    
}
