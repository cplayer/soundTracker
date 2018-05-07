//
//  Recorder.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Recorder {
    var recorder : AVAudioRecorder?
    var outputFilePath : String?
    var recordSetting : Dictionary<String, Any>?
    var timer : Timer!
    var timeFlag : Int
    var player : AVAudioPlayer?
    
    init () {
        recordSetting = [
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
            // 单声道
            AVNumberOfChannelsKey: 1,
            // 每秒录音样本数
            AVSampleRateKey: 48000,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        timeFlag = 0
    }
    
    func record () {
        let session : AVAudioSession = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
        try! session.setActive(true)
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        outputFilePath = docDir + "/record.wav"
        
        recorder = try! AVAudioRecorder(url: URL(string: outputFilePath!)!, settings: recordSetting!)
        if (recorder != nil) {
            recorder!.prepareToRecord()
            recorder!.record()
            timeFlag = 0
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkStop), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func checkStop () {
        timeFlag += 1
        if (timeFlag > 20) {
            timer.invalidate()
            recorder?.stop();
            recorder = nil;
        }
    }
    
    func play () {
        player = try! AVAudioPlayer(contentsOf: URL(string: outputFilePath!)!)
        if (player == nil) {
            print("Play Failed!")
        } else {
            player?.play()
        }
    }
}
