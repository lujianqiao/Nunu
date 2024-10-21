//
//  VideoCallViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/16.
//

import UIKit

class VideoCallViewController: UIViewController {

    var chat: ChatPartnerModel = ChatPartnerModel()
    
    lazy var BGImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chat_bg")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var leftImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chat_bg_center_left")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var centerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chat_bg_center")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var rightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chat_bg_center_right")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: self.chat.image)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 34
        image.clipsToBounds = true
        return image
    }()
    
    
    lazy var hangUpbutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "hang_up_two"), for: .normal)
        btn.addTarget(self, action: #selector(hangUpbuttonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var hangUplabel: UILabel = {
        let lab = UILabel()
        lab.text = "hang up"
        lab.textColor = .init(hex: "#9E9E9E")
        lab.font = .systemFont(ofSize: 12)
        return lab
    }()
    
    var timer: Timer?
    var timingNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    func setUpUI() {
        view.addSubview(BGImage)
        BGImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(leftImage)
        leftImage.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.top.equalTo(240)
            make.width.equalTo(114)
            make.height.equalTo(103)
        }
        
        view.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(leftImage)
            make.width.height.equalTo(105)
        }
        
        centerImage.addSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(68)
        }
        
        view.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.right.equalTo(-8)
            make.centerY.equalTo(leftImage)
            make.width.equalTo(114)
            make.height.equalTo(103)
        }
        
        
        
        view.addSubview(hangUplabel)
        hangUplabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(79.5)
        }
        
        view.addSubview(hangUpbutton)
        hangUpbutton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(hangUplabel.snp.top).offset(-13.5)
            make.width.height.equalTo(59)
        }
        
       
        timer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(update(timer:)),
                                             userInfo: nil,
                                             repeats: true)
        
        
    }
    
    @objc func update(timer: Timer) {
        timingNum  = timingNum + 1
        
        print("timingNum==\(timingNum)")
        
        if timingNum % 2 == 0 {
            playAudio()
        }
        
        if timingNum >= 60 {
            self.dismiss(animated: true)
        }
    }
    
    @objc func hangUpbuttonAction() {
        self.dismiss(animated: true)
    }
    
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "1000", ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        GToolsAudioPlayer.shared.playAudioWithUrl(url: url)
    }
    
}
