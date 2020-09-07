//
//  FDIMMessageModel.swift
//  FDIMKit
//
//  Created by fandongtongxue on 2020/8/22.
//

import HandyJSON

public enum FDIMMessageType {
    case none = -1
    case text //文字消息
    case send_gift_success //收到礼物消息
    case pop_msg //弹幕
    case creater_exit_room //主播退出直播间
    case forbid_send_msg //禁止发送消息
    case viewer_join //观众进入直播间
    case viewer_quit //观众退出直播间
    case end_video //直播结束消息
    case red_packer //红包
    case living_message //直播消息
    case anchor_leave //主播离开
    case anchor_back //主播回来
    case light //点亮
    case apply_mike //观众申请连麦
    case receive_mike //主播接受连麦
    case refuse_mike //主播拒绝连麦
    case break_mike //断开连麦
    case system_close_live //违规直播，立即关闭直播，私密直播被主播踢出直播间
    case live_stop //直播结束
    case private_text = 20 //私聊文字消息
    case private_voice //私聊语音消息
    case private_image //私聊图片消息
    case private_gift //私聊礼物消息
    case pai_success = 25 //拍卖成功
    case pai_pay_tip //推送支付提醒
    case pai_fault //流拍
    case pai_add_price //加价推送
    case pai_pay_success //支付成功
    case release_success //主播发起竞拍成功
    case stargoods_success //主播发起商品推送成功
    case paymoney_success //主播发起付费直播成功
    case goldengame_count //炸金花统计下注
    case game_over //游戏结束推送
    case goldengame_start //选择开始游戏
    case goldengame_bet //炸金花下注
    case buygoods_success //观众购买商品成功
    case game_income //游戏收益推送
    case game_all //游戏总的推送
    case paymoneyseason_success //主播发起付费直播成功
    case background_monitoring //后台监控
    case refresh_audience_list //刷新观众列表
    case game_banker //游戏上庄相关推送
    case big_gift_notice_all = 50 //直播间飞屏模式
    case request_pk = 56 // 请求pk
    case accept_pk // 同意pk
    case reject_pk //拒绝pk
    case stop_pk //停止pk
    case cancel_pk //取消pk
    case start_pk //通知房间开始pk
    case end_pk //pk结束
    case update_pk_ticket = 70//更新pk收益
    case msg_wish_update //更新直播间心愿列表
    case open_guard_success = 81 // 开启守护之后群组通知
    case receive_broadcast // 全局广播通知
    case win_prize = 88 //中奖提示消息
}

public class FDIMMessageModel : HandyJSON {
    public var showNum: String?
    public var sex: String?
    public var top_title: String?
    public var timestamp: String?
    public var goods: String?
    public var redPackageTip: String?
    public var user_prop_id: String?
    public var iconImage: String?
    public var room_id: String?
    public var anim_cfg: String?
    public var time: String?
    public var dicData: String?
    public var banker_status: String?
    public var nick_name: String?
    public var pkid: String?
    public var sender: FDIMMessageModelSender?
    public var is_guardian: Int = 0
    public var play_rtmp2_acc: String?
    public var data: String?
    public var showMsg: String?
    public var isShowLightMessage: Int = 0
    public var game_log_id: String?
    public var action: String?
    public var play_rtmp_acc: String?
    public var game_action: String?
    public var user_multiple: String?
    public var buyer: String?
    public var desc: String?
    public var is_self: String?
    public var msg: String?
    public var isTaked: String?
    public var is_vip: String?
    public var text: String?
    public var podcast_income: String?
    public var option: String?
    public var game_data: String?
    public var fonts_color: String?
    public var pk_id: String?
    public var user_id: String?
    public var is_animated: String?
    public var diamonds: String?
    public var push_rtmp2: String?
    public var banker_list: String?
    public var auto_start: String?
    public var win_user_id: String?
    public var desc2: String?
    public var is_much: String?
    public var to_user_id: String?
    public var data_type: String?
    public var num: String?
    public var score: String?
    public var imageName: String?
    public var prop_id: String?
    public var type: FDIMMessageType
    public var is_plus: String?
    public var icon: String?
    public var isRedPackageTaked: String?
    public var anim_type: String?
    public var total_ticket: String?
    public var user: FDIMMessageModelUser?
    public var head_image: String?
    public var status: String?
    public var game_id: String?
    public var show_num: String?
    public var banker: String?
    public var bet_option: String?
    public var game_status: String?
    public var animated_url: String?
    public var chatGroupID: String?
    
    public func getSize() -> CGSize {
        let content : String!
        switch type {
        case FDIMMessageType.text.rawValue:
            content = (sender?.user_id)! + ":" + text!
        case FDIMMessageType.viewer_join.rawValue:
            content = "直播消息:" + (sender?.user_id)! + "来了"
        case FDIMMessageType.living_message.rawValue:
            content = "直播消息:" + desc!
        default:
            content = ""
        }
        let width = content?.getWidth(font: UIFont.systemFont(ofSize: 15, weight: .medium), maxWidth: CGFloat(FDLiveKit_Screen_Width * 0.8), maxHeight: CGFloat(MAXFLOAT))
        let height = content?.getHeight(font: UIFont.systemFont(ofSize: 15, weight: .medium), maxWidth: CGFloat(FDLiveKit_Screen_Width * 0.8), maxHeight: CGFloat(MAXFLOAT))
        print("当前行宽:%f 高:%f",width as Any,height as Any)
        return CGSize.init(width: width!, height: height!)
    }
    
    required public init() {}
}

public class FDIMMessageModelUser : HandyJSON{
    public var city: String?
    public var fans_count: String?
    public var id: String?
    public var nick_name: String?
    public var use_diamonds: String?
    public var ticket: String?
    public var home_url: String?
    public var name: String?
    public var job: String?
    public var province: String?
    public var item: String?
    public var focus_count: String?
    public var user_level: String?
    public var is_authentication: String?
    public var v_explain: String?
    public var title: String?
    public var head_image: String?
    public var v_icon: String?
    public var v_type: String?
    public var sex: String?
    public var n_focus_count: String?
    public var n_use_diamonds: String?
    public var luck_num: String?
    public var birthday: String?
    public var n_fans_count: String?
    public var num: String?
    public var signature: String?
    public var cate_id: String?
    public var user_id: String?
    public var emotional_state: String?
    
    required public init() {}
}

public class FDIMMessageModelSender : HandyJSON{
    public var user_id: String?
    public var noble_stealth: String?
    public var id: String?
    public var user_level: Int = 0
    public var nick_name: String?
    public var noble_silence: String?
    public var is_vip: Int = 0
    public var family_chieftain: String?
    public var noble_barrage: String?
    public var watch_number_format: String?
    public var car_svga: String?
    public var mysterious_picture: String?
    public var noble_medal: String?
    public var noble_experience: String?
    public var mysterious_name: String?
    public var room_id: String?
    public var follow_id: String?
    public var noble_car: String?
    public var is_noble_mysterious: String?
    public var noble_icon: String?
    public var guardian: Int = 0
    public var is_guardian: Int = 0
    public var group_id: String?
    public var has_car: String?
    public var noble_special_effects: String?
    public var title: String?
    public var noble_car_url: String?
    public var begin_time_format: String?
    public var text: String?
    public var head_image: String?
    public var v_type: String?
    public var sort_num: String?
    public var v_icon: String?
    public var noble_avatar: String?
    public var sex: String?
    public var noble_is_avatar: String?
    public var live_in: String?
    public var num: String?
    public var noble_vip_type : String?
    public var signature: String?
    public var cate_id: String?
    public var star_box: String?
    public var noble_car_name: String?
    
    required public init() {}
}

