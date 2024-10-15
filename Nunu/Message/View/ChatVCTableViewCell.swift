//
//  ChatVCTableViewCell.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/16.
//

import UIKit

class ChatVCTableViewCell: UITableViewCell {

    private var MaxWidth: Double = 200
    
    lazy var avatarButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var chatBGImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "message_text_bg_left")?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10), resizingMode: .stretch)
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var messageText: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = .systemFont(ofSize: 12)
        lab.textColor = .black
        lab.numberOfLines = 0
        return lab
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(avatarButton)
        avatarButton.snp.makeConstraints { make in
            make.left.equalTo(26)
            make.top.equalTo(15)
            make.width.height.equalTo(50)
        }
     
        contentView.addSubview(chatBGImage)
        chatBGImage.snp.makeConstraints { make in
            make.left.equalTo(84)
            make.top.bottom.equalToSuperview().inset(17)
            make.width.equalTo(48)
            make.height.equalTo(39)
        }
        
        chatBGImage.addSubview(messageText)
        messageText.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().offset(10)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func loadMessage(with message: String) {
        if let _ = LUConstant.getUserDefaultsData(with: LUConstant.userTokenKey) {
            if let imageData = LUConstant.getUserDefaultsValue(with: LUConstant.userAvatarKey) {
                avatarButton.setImage(UIImage(data: imageData), for: .normal)
            } else {
                avatarButton.setImage(.init(named: "default_avatar"), for: .normal)
            }
        }
        messageText.text = message
        
        let labelWith = messageText.labelWidth(height: 15)
        if labelWith < MaxWidth {
            chatBGImage.snp.updateConstraints { make in
                make.width.equalTo(labelWith + 15)
            }
        } else {
            let labelHeight = messageText.labelHeight(width: MaxWidth)
            chatBGImage.snp.updateConstraints { make in
                make.width.equalTo(MaxWidth + 15)
                make.height.equalTo(labelHeight + 10)
            }
        }
    }
    
    
}


class ChatVCPartnerTableViewCell: UITableViewCell {

    private var MaxWidth: Double = 200
    
    lazy var avatarButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var chatBGImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "message_text_bg_right")?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10), resizingMode: .stretch)
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var messageText: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = .systemFont(ofSize: 12)
        lab.textColor = .black
        lab.numberOfLines = 0
        return lab
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(avatarButton)
        avatarButton.snp.makeConstraints { make in
            make.right.equalTo(-26)
            make.top.equalTo(15)
            make.width.height.equalTo(50)
        }
     
        contentView.addSubview(chatBGImage)
        chatBGImage.snp.makeConstraints { make in
            make.right.equalTo(-84)
            make.top.bottom.equalToSuperview().inset(17)
            make.width.equalTo(48)
            make.height.equalTo(39)
        }
        
        chatBGImage.addSubview(messageText)
        messageText.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().offset(10)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func loadMessage(with message: String, avatar: String) {
        
        avatarButton.setImage(.init(named: avatar), for: .normal)
        messageText.text = message
        
        let labelWith = messageText.labelWidth(height: 15)
        if labelWith < MaxWidth {
            chatBGImage.snp.updateConstraints { make in
                make.width.equalTo(labelWith + 15)
            }
        } else {
            let labelHeight = messageText.labelHeight(width: MaxWidth)
            chatBGImage.snp.updateConstraints { make in
                make.width.equalTo(MaxWidth + 15)
                make.height.equalTo(labelHeight + 10)
            }
        }
    }
    
    
}
