//
//  MySessionConfig.swift
//  SchoolChat
//
//  Created by ZL on 16/6/19.
//  Copyright © 2016年 WoF. All rights reserved.
//

import Foundation

class MySessionConfig: NSObject, NIMSessionConfig {
    
    func mediaItems() -> [NIMMediaItem]! {
        return [
            NIMMediaItem.init(1, normalImage: UIImage.init(named:"bk_media_picture_normal"), selectedImage: UIImage.init(named:"bk_media_picture_normal_pressed"), title: "相册"),
            NIMMediaItem.init(2, normalImage: UIImage.init(named:"bk_media_shoot_normal"), selectedImage: UIImage.init(named:"bk_media_shoot_normal_pressed"), title: "拍摄"),
            NIMMediaItem.init(3, normalImage: UIImage.init(named:"btn_media_telphone_message_normal"), selectedImage: UIImage.init(named:"btn_media_telphone_message_pressed"), title: "语音"),
            NIMMediaItem.init(4, normalImage: UIImage.init(named:"btn_bk_media_video_chat_normal"), selectedImage: UIImage.init(named:"btn_bk_media_video_chat_pressed"), title: "视频")
        ]
        
    }

    
}
