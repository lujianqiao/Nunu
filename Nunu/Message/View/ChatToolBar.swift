//
//  ChatToolBar.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/15.
//

import UIKit

class ChatToolBar: UIView {

    
    var sendMessageBlock: ((String)->Void)?
    var videoCallBlock:(()->Void)?
    
    lazy var videoButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "message_video"), for: .normal)
        btn.addTarget(self, action: #selector(videoButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var textFiled: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    lazy var sendButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "message_send"), for: .normal)
        btn.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .init(hex: "#1D2130")
        addSubview(videoButton)
        videoButton.snp.makeConstraints { make in
            make.left.equalTo(13)
            make.top.equalTo(17)
            make.width.height.equalTo(30)
        }
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(17)
            make.top.equalTo(13)
            make.width.height.equalTo(30)
        }
        
        addSubview(textFiled)
        textFiled.snp.makeConstraints { make in
            make.left.equalTo(videoButton.snp.right).offset(10)
            make.right.equalTo(sendButton.snp.left).offset(-10)
            make.top.equalTo(12.5)
            make.height.equalTo(37.5)
        }
    }
    
    @objc func sendButtonAction() {
        guard let message = textFiled.text else {return}
        guard let block = sendMessageBlock else {return}
        block(message)
        textFiled.text = nil
    }
    
    @objc func videoButtonAction() {
        guard let block = videoCallBlock else {return}
        block()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
