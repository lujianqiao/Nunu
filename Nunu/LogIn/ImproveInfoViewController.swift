//
//  ImproveInfoViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/5.
//

import UIKit
import TZImagePickerController

class ImproveInfoViewController: UIViewController {

    @IBOutlet weak var cameraBGView: UIView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var nickNameInput: UITextField!
    
    @IBOutlet weak var boyBGView: UIView!
    @IBOutlet weak var boySelectView: UIView!
    
    @IBOutlet weak var girlBGView: UIView!
    @IBOutlet weak var girlSelectView: UIView!
    
    @IBOutlet weak var fineBGView: UIView!
    @IBOutlet weak var fineSelectView: UIView!
    
    /// -1 未知，0女，1男
    var genderIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraBGView.layer.cornerRadius = 50
        cameraBtn.clipsToBounds = true
        cameraBtn.layer.cornerRadius = 45
        cameraBtn.addTarget(self, action: #selector(cameraBtnAction), for: .touchUpInside)
        nickNameInput.delegate = self
        boySelectView.layer.cornerRadius = 7
        girlSelectView.layer.cornerRadius = 7
        fineSelectView.layer.cornerRadius = 7
        
        
        let boyBGViewTap = UITapGestureRecognizer(target: self, action: #selector(boyBGViewTapAction))
        boyBGView.addGestureRecognizer(boyBGViewTap)
        
        let girlBGViewTap = UITapGestureRecognizer(target: self, action: #selector(girlBGViewTapAction))
        girlBGView.addGestureRecognizer(girlBGViewTap)
        
        let fineBGViewTap = UITapGestureRecognizer(target: self, action: #selector(fineBGViewTapAction))
        fineBGView.addGestureRecognizer(fineBGViewTap)
        
    }
    
    
    @objc func cameraBtnAction() {
        guard let picker = TZImagePickerController.init(maxImagesCount: 1, delegate: self) else {return}
        present(picker, animated: true)
    }

    @IBAction func nextStepAction(_ sender: Any) {
        guard let name = nickNameInput.text else {
            LUHUD.showText(text: "Please enter your nickname")
            return
        }
        guard let gender = genderIndex else {
            LUHUD.showText(text: "Please select your gender")
            return
        }
        
        // 接口有问题，本地保存数据
        let hud = LUHUD.showHUD()
        httpProvider.request(.improveInfo(name, gender)) { result in
            hud.hide(animated: true)
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                
//                let delegate = LUConstant.getSceneDelegate()
//                delegate?.window?.rootViewController = LUTabBarController()
                
                if let imageData = LUConstant.getUserDefaultsValue(with: LUConstant.userAvatarKey) {
                    UserInfoManager.share.userInfo.userAvatar = imageData
                }
                UserInfoManager.share.userInfo.nick_name = name
                UserInfoManager.share.userInfo.userGender = gender
                
                
                if self.navigationController?.viewControllers.contains(where: {$0 .isKind(of: RegisterViewController.self)}) == true {
                    let delegate = LUConstant.getSceneDelegate()
                    delegate?.window?.rootViewController = LUTabBarController()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
                
            case .failure(let _):
                hud.hide(animated: true)
                LUHUD.showText(text: "Data anomalies")
            }
        }
    }
    
    @objc func boyBGViewTapAction() {
        genderIndex = 1
        boySelectView.backgroundColor = .init(red: 235 / 255, green: 85 / 255, blue: 155 / 255, alpha: 2)
        girlSelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        fineSelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
    }
    
    @objc func girlBGViewTapAction() {
        genderIndex = 0
        boySelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        girlSelectView.backgroundColor = .init(red: 235 / 255, green: 85 / 255, blue: 155 / 255, alpha: 2)
        fineSelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
    }
    
    @objc func fineBGViewTapAction() {
        genderIndex = -1
        boySelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        girlSelectView.backgroundColor = .init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        fineSelectView.backgroundColor = .init(red: 235 / 255, green: 85 / 255, blue: 155 / 255, alpha: 2)
    }
}

extension ImproveInfoViewController: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        guard let image = photos.first else { return }
        cameraBtn.setImage(image, for: .normal)
        
        let imgData = image.compressImage()
        
        LUConstant.setUserDefaultsValue(with: imgData, key: LUConstant.userAvatarKey)
        
    }
}

extension ImproveInfoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
