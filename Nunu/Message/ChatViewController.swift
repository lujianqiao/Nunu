//
//  ChatViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/15.
//

import UIKit

class ChatViewController: UIViewController {

    var chatID: ChatPartnerModel = ChatPartnerModel()
    private var messages: [ChatConversationData] = []
    
//    private var datas: [String] = []
    
    lazy var chatBar: ChatToolBar = {
        let vc = ChatToolBar()
        vc.layer.cornerRadius = 20
        vc.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return vc
    }()
    
    
    lazy var tableview: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = .clear
        tab.register(ChatVCTableViewCell.self, forCellReuseIdentifier: String(describing: ChatVCTableViewCell.self))
        tab.register(ChatVCPartnerTableViewCell.self, forCellReuseIdentifier: String(describing: ChatVCPartnerTableViewCell.self))
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getChatData()
        // Do any additional setup after loading the view.
    }

    func setUpUI() {
        view.backgroundColor = .main
        view.addSubview(chatBar)
        chatBar.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(52.5 + LUConstant.DSafeDistanceBottom())
        }
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(LUConstant.DNavigationFullHeight())
            make.bottom.equalTo(chatBar.snp.top)
        }
        
        chatBar.videoCallBlock = {[weak self] in
            guard let self = self else {return}
            let vc = VideoCallViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.chat = self.chatID
            self.present(vc, animated: true)
        }
        
        chatBar.sendMessageBlock = {[weak self] message in
            guard let self = self else {return}
            self.sendMessage(with: chatID.id, message: message)
            self.tableview.reloadData()
        }
    }
    
    
    
    func sendMessage(with chatID: String, message: String) {
        
        var userMessage = ChatConversationData()
        userMessage.message = message
        userMessage.isUSer = true
        messages.append(userMessage)
        tableview.reloadData()
        self.scrollToBottom()
        
        httpProvider.request(.sendChat(chatID, "hello")) { result in
            
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? String else {return}
                
                var userMessage = ChatConversationData()
                userMessage.message = data
                userMessage.isUSer = false
                self.messages.append(userMessage)
                self.tableview.reloadData()
                self.scrollToBottom()
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
    }
    


    /// 获取聊天数据
    func getChatData() {
        let hud = LUHUD.showHUD()
        httpProvider.request(.getChatRecordData(self.chatID.id, 1, 100)) { result in
            hud.hide(animated: true)
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [String: Any] else {return}
                guard let messageData =  data["data"] as? [Any] else {return}
                guard let models = [ChatListModelRecord].deserialize(from: messageData) else {return}
                
                for item in models {
                    var userMessage = ChatConversationData()
                    userMessage.message = item.question
                    userMessage.isUSer = true
                    
                    var partnerMessage = ChatConversationData()
                    partnerMessage.message = item.answer
                    partnerMessage.isUSer = false
                    
                    self.messages.append(userMessage)
                    self.messages.append(partnerMessage)
                }
                
                self.tableview.reloadData()
                self.scrollToBottom()
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
    }

    
    func scrollToBottom() {
        guard messages.count > 0 else {return}
        let lastRowIndex = messages.count - 1
        let indexPath = IndexPath(row: lastRowIndex, section: 0)
        tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}
    

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.isUSer {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatVCTableViewCell.self)) as! ChatVCTableViewCell
            cell.loadMessage(with: message.message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatVCPartnerTableViewCell.self)) as! ChatVCPartnerTableViewCell
            cell.loadMessage(with: message.message, avatar: chatID.image)
            return cell
        }
    }
    
    
}
