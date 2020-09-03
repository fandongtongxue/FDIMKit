//
//  FDIMManager.swift
//  FDIMKit
//
//  Created by fandongtongxue on 2020/8/22.
//

import Foundation
import ImSDK

public typealias FDIMSucc = () -> ()
public typealias FDIMFailure = (Int32,String) -> ()

public protocol FDIMManagerDelegate {
    func onRecvGroupCustomMessage(_ group_id : String,_ model : FDIMMessageModel)
    func onRecvC2CCustomMessage(_ uid : String,_ model : FDIMMessageModel)
}

public class FDIMManager : NSObject{
    
    public var delegate : FDIMManagerDelegate?
    
    public var sender : FDIMMessageModelSender?
    
    public static let manager = FDIMManager()

    @objc public class func defaultManager() -> FDIMManager {
        return manager
    }
    
    public func registerApp(_ sdkAppId : Int32) {
        let config = V2TIMSDKConfig.init()
        V2TIMManager.sharedInstance()?.initSDK(sdkAppId, config: config, listener: self)
        V2TIMManager.sharedInstance()?.add(self)
    }
    
    @objc public func login(_ user_id : String, _ userSig : String, _ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        V2TIMManager.sharedInstance()?.login(user_id, userSig: userSig, succ: {
            success()
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
    
    @objc public func logout(_ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        V2TIMManager.sharedInstance()?.logout({
            success()
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
    
    @objc public func getLoginUser() -> String {
        return (V2TIMManager.sharedInstance()?.getLoginUser())!
    }
    
    @objc public func joinGroup(_ group_id : String, _ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        V2TIMManager.sharedInstance()?.joinGroup(group_id, msg: "进入直播间", succ: {
            success()
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
    
    @objc public func quitGroup(_ group_id : String, _ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        V2TIMManager.sharedInstance()?.quitGroup(group_id, succ: {
            success()
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
    
    public func sendC2CCustomMessage(model : FDIMMessageModel, _ touid : String, _ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        model.sender = self.sender
        let json = model.toJSONString()
        let data = json?.data(using: .utf8)
        V2TIMManager.sharedInstance()?.sendC2CCustomMessage(data, to: touid, succ: {
            success()
            print("发送自定义C2C消息开始")
            print(model.toJSON() as Any)
            print("发送自定义C2C消息结束")
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
    
    public func sendGroupCustomMessage(model : FDIMMessageModel, _ group_id : String, _ success : @escaping FDIMSucc, _ failure : @escaping FDIMFailure) {
        model.sender = self.sender
        let json = model.toJSONString()
        let data = json?.data(using: .utf8)
        model.chatGroupID = group_id
        V2TIMManager.sharedInstance()?.sendGroupCustomMessage(data, to: group_id, priority: .PRIORITY_DEFAULT, succ: {
            success()
            print("发送自定义群组消息开始")
            print(model.toJSON() as Any)
            print("发送自定义群组消息结束")
        }, fail: { (code, msg) in
            failure(code,msg!)
        })
    }
}

extension FDIMManager : V2TIMSDKListener{
    public func onKickedOffline() {
        //提示用户被踢下线
    }
    
    public func onUserSigExpired() {
        //提示用户签名过期
    }
    
}

extension FDIMManager : V2TIMAdvancedMsgListener{
    public func onRecvNewMessage(_ msg: V2TIMMessage!) {
        if msg.groupID != nil {
            //群组消息
            if msg.customElem.data != nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: msg.customElem.data, options: .mutableContainers) as! NSDictionary
                    let model = FDIMMessageModel.deserialize(from: dict)!
                    print("收到自定义群组消息开始")
                    print(model.toJSON() as Any)
                    print("收到自定义群组消息结束")
                    if delegate != nil {
                        delegate?.onRecvGroupCustomMessage(msg.groupID, model)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        if msg.userID != nil {
            //C2C消息
            if msg.customElem.data != nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: msg.customElem.data, options: .mutableContainers) as! NSDictionary
                    let model = FDIMMessageModel.deserialize(from: dict)!
                    print("收到自定义C2C消息开始")
                    print(model.toJSON() as Any)
                    print("收到自定义C2C消息结束")
                    if delegate != nil {
                        delegate?.onRecvGroupCustomMessage(msg.userID, model)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
