//
//  ChatViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/15.
//

import UIKit

class ChatViewController: UIViewController {

    var chatID: String = ""
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
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
            self.present(vc, animated: true)
        }
        
        chatBar.sendMessageBlock = {[weak self] message in
            guard let self = self else {return}
//            self.datas.append(message)
            addMessage(with: chatID, message: message)
            self.tableview.reloadData()
        }
    }
    
    
    func addMessage(with chatID: String, message: String) {
        guard let allData =  LUConstant.getUserDefaultsValue(with: LUConstant.userChatDataKey) else {
            
            let firstMessage: [String: [String]] = [chatID: [message]]
            if let firstData = LUConstant.jsonToData(jsonDic: firstMessage) {
                LUConstant.setUserDefaultsValue(with: firstData, key: LUConstant.userChatDataKey)
            }
            
            return
        }
        
        guard var dataJson = LUConstant.dataToDictionary(data: allData) else {return}
        if var messages = dataJson[chatID] as? [String] {
            messages.append(message)
            dataJson[chatID] = messages
        } else {
            dataJson[chatID] = [message]
        }
        
        if let resultData = LUConstant.jsonToData(jsonDic: dataJson) {
            LUConstant.setUserDefaultsValue(with: resultData, key: LUConstant.userChatDataKey)
        }
    }
    
    func readMessage(with chatID: String) -> [String] {
        guard let allData =  LUConstant.getUserDefaultsValue(with: LUConstant.userChatDataKey) else {return []}
        guard var dataJson = LUConstant.dataToDictionary(data: allData) else {return []}
        guard var messages = dataJson[chatID] as? [String] else {return []}
        
        return messages
    }

}
    

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readMessage(with: chatID).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatVCTableViewCell.self)) as! ChatVCTableViewCell
        let message = readMessage(with: chatID)[indexPath.row]
        cell.loadMessage(with: message)
        return cell
    }
    
    
}
