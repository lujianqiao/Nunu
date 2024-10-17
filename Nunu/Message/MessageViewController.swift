//
//  MessageViewController.swift
//  Nunu
//
//  Created by lujianqiao on 2024/8/31.
//

import UIKit

class MessageViewController: UIViewController {

    private var listData: [ChatListModel] = []
    lazy var tableview: UITableView = {
        let tab = UITableView(frame: .zero, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = .clear
        tab.register(UINib(nibName: String(describing: MessageViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MessageViewCell.self))
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllChatListData()
    }

}

extension MessageViewController {
    func setUpUI() {
        view.backgroundColor = .init(red: 22 / 255, green: 25 / 255, blue: 35 / 255, alpha: 1)
        title = "Message"
        
//        let barBtn = UIBarButtonItem.init(image: .init(named: "delete"), style: .plain, target: self, action: #selector(deleteAction))
//        barBtn.tintColor = .white
//        navigationItem.rightBarButtonItem = barBtn
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(LUConstant.DNavigationFullHeight())
        }
    }
    
    @objc func deleteAction() {
        
    }
    
    func getAllChatListData() {
        
        let hud = LUHUD.showHUD()
        httpProvider.request(.getAllChatList) { result in
            hud.hide(animated: true)
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) as? [String: Any] else {return}
                guard let data = json["data"] as? [Any] else {return}
                guard let models = [ChatListModel].deserialize(from: data) else {return}
                
                self.listData = models
                self.tableview.reloadData()
                
            case .failure(_):
                LUHUD.showText(text: "Data anomalies")
            }
            
        }
        
    }

    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageViewCell.self)) as! MessageViewCell
        let chat = listData[indexPath.section]
        cell.userAvatar.image = UIImage(named: "message_\(chat.id)")
        cell.messageLab.text = chat.record.answer
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tabbar = self.tabBarController as? LUTabBarController {
            tabbar.customTabbar.isHidden = true
        }
        let chatID = listData[indexPath.section]
        let vc = ChatViewController()
        var chat = ChatPartnerModel()
        chat.id = chatID.id
        chat.image = "message_\(chatID.id)"
        
        vc.chatID = chat
        navigationController?.pushViewController(vc, animated: true)
    }
}
