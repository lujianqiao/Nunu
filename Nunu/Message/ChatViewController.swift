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
//            self.datas.append(message)
//            self.addMessage(with: chatID.id, message: message)
            self.sendMessage(with: chatID.id, message: message)
            self.tableview.reloadData()
        }
    }
    
    
//    func addMessage(with chatID: String, message: String) {
//        guard let allData =  LUConstant.getUserDefaultsValue(with: LUConstant.userChatDataKey) else {
//            
//            let firstMessage: [String: [String]] = [chatID: [message]]
//            if let firstData = LUConstant.jsonToData(jsonDic: firstMessage) {
//                LUConstant.setUserDefaultsValue(with: firstData, key: LUConstant.userChatDataKey)
//            }
//            
//            return
//        }
//        
//        guard var dataJson = LUConstant.dataToDictionary(data: allData) else {return}
//        if var messages = dataJson[chatID] as? [String] {
//            messages.append(message)
//            dataJson[chatID] = messages
//        } else {
//            dataJson[chatID] = [message]
//        }
//        
//        if let resultData = LUConstant.jsonToData(jsonDic: dataJson) {
//            LUConstant.setUserDefaultsValue(with: resultData, key: LUConstant.userChatDataKey)
//        }
//    }
    
    func sendMessage(with chatID: String, message: String) {
        
        var userMessage = ChatConversationData()
        userMessage.message = message
        userMessage.isUSer = true
        messages.append(userMessage)
        tableview.reloadData()
        
        
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
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
    }

}
    

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return readMessage(with: chatID.id).count
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
