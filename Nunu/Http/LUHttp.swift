//
//  LUHttp.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/9.
//

import Foundation
import Moya

let httpProvider = MoyaProvider<LUHttp>()

enum LUHttp {
    
    case register(_ account: String, _ passwd: String)
    case improveInfo(_ name: String, _ gender: Int)
    case quickLogon
    case getUserInfo
    /// 充值列表
    case payConfigList
    /// 苹果购买成功，将购买凭证发给服务器验证
    case verifyPurchaseProof(_ pay_id: String, _ receipt_data: String, _ transaction_id: String, _ env: Int)
    /// AI列表
    case getAiList
    /// 发起聊天
    case sendChat(_ id: String, _ message: String)
    /// 所有聊天列表
    case getAllChatList
    /// 指定聊天记录
    case getChatRecordData(_ bot_id: String, _ page: Int, _ page_size: Int)
}

extension LUHttp: TargetType {
    var baseURL: URL {
        return URL.init(string: "https://api-chat.ybloffical.club/api")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/user/registerEmail"
        case .improveInfo:
            return "/user/updateProfile"
        case .quickLogon:
            return "/user/loginGuest"
        case .getUserInfo:
            return "/user/userInfo"
        case .payConfigList:
            return "/pay/confList"
        case .verifyPurchaseProof:
            return "/pay/subscribe"
        case .getAiList:
            return "/ai/AIList"
        case .sendChat:
            return "/ai/question"
        case .getAllChatList:
            return "/ai/chatAIList"
        case .getChatRecordData:
            return "/ai/questionList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, 
                .improveInfo,
                .quickLogon,
                .getUserInfo,
                .payConfigList,
                .verifyPurchaseProof,
                .getAiList,
                .sendChat,
                .getAllChatList,
                .getChatRecordData:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .register(let account, let pw):
            
            let params = ["email": account, "password": pw]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
        case .improveInfo(let name, let gender):
            let params: [String: Any] = ["nick_name": name, "sex": gender]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
        case .quickLogon:
            let uuid = LUConstant.UUID
            debugPrint("UUID=====\(uuid)")
            let params: [String: Any] = ["uuid": uuid]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
        case .verifyPurchaseProof(let pay_id, let receipt_data, let transaction_id, let env):
            let params: [String: Any] = ["pay_id": pay_id, "receipt_data": receipt_data, "transaction_id": transaction_id, "env": env]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
            
        case .sendChat(let id, let message):
            
            let params: [String: Any] = ["bot_id": id, "question": message]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
            
        case .getChatRecordData(let bot_id, let page, let page_size):
            let params: [String: Any] = ["bot_id": bot_id, "page": page, "page_size": page_size]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
        case .getUserInfo, .payConfigList, .getAiList, .getAllChatList:
            return .requestCompositeData(bodyData: Data(), urlParameters:[:])
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        header["Content-Type"] = "application/json"
        
        if let auth = LUConstant.getUserDefaultsData(with: LUConstant.userTokenKey) {
            header["Authorization"] = auth
        }
        
        return header
    }
    
    
}


