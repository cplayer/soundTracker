//
//  Recorder.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import Foundation
import AVFoundation

class Recorder {
    var recorder : AVAudioRecorder?
    var outputFilePath : String?
    var recordSetting : Dictionary<String, Any>?
    
    init () {
        recordSetting = [
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
            // 单声道
            AVNumberOfChannelsKey: 1,
            // 每秒录音样本数
            AVSampleRateKey: 48000,
            AVEncoderAudioQualityKey: AVAudioQuality.low.rawValue
        ]
    }
    
    func record () {
        let session : AVAudioSession = AVAudioSession.sharedInstance()
    }
}
