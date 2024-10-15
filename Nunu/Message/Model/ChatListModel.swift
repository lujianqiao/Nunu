//
//  ChatListModel.swift
//  Nunu
//
//  Created by lujianqiao on 2024/10/15.
//

import UIKit
import SmartCodable

struct ChatListModel: SmartCodable {

    var id: String = ""
    var system: String = ""
    var record: ChatListModelRecord = ChatListModelRecord()
}

struct ChatListModelRecord: SmartCodable {
    var id: String = ""
    var question: String = ""
    var answer: String = ""
}


struct ChatConversationData: SmartCodable {
    
    var message: String = ""
    var isUSer: Bool = false
    
}
