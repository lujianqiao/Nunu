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
        image.image = UIImage(named: chat.image)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var hangUpbutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "hang_up"), for: .normal)
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
        
        
        view.addSubview(hangUplabel)
        hangUplabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(79.5)
        }
        
        view.addSubview(hangUpbutton)
        hangUpbutton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(hangUplabel.snp.top).offset(13.5)
            make.width.height.equalTo(72)
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
        if timingNum >= 60 {
            self.dismiss(animated: true)
        }
    }
    
    @objc func hangUpbuttonAction() {
        self.dismiss(animated: true)
    }
    
}
