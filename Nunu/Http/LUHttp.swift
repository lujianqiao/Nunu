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
    case payConfigList
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .improveInfo, .quickLogon, .getUserInfo, .payConfigList:
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
            let params: [String: Any] = ["uuid": uuid]
            let data = try! JSONSerialization.data(withJSONObject:params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return .requestCompositeData(bodyData: data, urlParameters:[:])
            
        case .getUserInfo, .payConfigList:
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


