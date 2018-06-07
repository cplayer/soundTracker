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
import Alamofire
import Kronos

extension Date {
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : TimeInterval {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        return timeInterval
    }
}

class Recorder {
    var recorder : AVAudioRecorder?
    var outputFilePath : String?
    var recordSetting : Dictionary<String, Any>?
    var timer : Timer!
    var timeFlag : Int
    var player : AVAudioPlayer?
    
    
    init () {
        recordSetting = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            // 单声道
            AVNumberOfChannelsKey: 1,
            // 每秒录音样本数
            AVSampleRateKey: 48000,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey:false,
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
            
            Alamofire.request("http://218.193.181.12:18020").responseString { response in
                if let data = response.data, let timetext = String(data: data, encoding: .ascii) {
                    let number = (timetext as NSString).doubleValue
                    let timeInterval:TimeInterval = TimeInterval(number/1000.0)
                    var now = Clock.now?.milliStamp
                    print("Expect: \(timeInterval); Now: \(String(describing: now))")
                    let sleeptime = timeInterval - now!
                    if sleeptime < 0.05 {
                        return
                    }
                    usleep(useconds_t(sleeptime*1000000) - 50000)
                    now = Clock.now?.milliStamp
                    print("Expect: \(timeInterval); Now: \(String(describing: now))")
                    self.recorder!.record()
                    self.timeFlag = 0
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.checkStop), userInfo: nil, repeats: true)
                    print("Start Recording!")
                }
            }
            
        }
        
    }
    
    @objc func checkStop () {
        timeFlag += 1
        if (timeFlag > 10) {
            timer.invalidate()
            recorder?.stop();
            recorder = nil;
            print("Stop Recording!")
            
            let sender = Sender()
            sender.send(_path: outputFilePath)
        }
    }
    
    func play () -> String? {
        player = try! AVAudioPlayer(contentsOf: URL(string: outputFilePath!)!)
        print(outputFilePath!)
        if (player == nil) {
            print("Play Failed!")
        } else {
            player?.play()
            print("Start Playing!")
        }
        return outputFilePath!
    }
}
