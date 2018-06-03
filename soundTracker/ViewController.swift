//
//  ViewController.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import UIKit
import Kronos

class ViewController: UIViewController {
    
    var recorder : Recorder!
    var path : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // let sender = Sender()
        // sender.send()
        Clock.sync(from: "202.120.2.101",first: { date, offset in
            print("Least accurate time: \(date)")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playRecord(_ sender: UIButton) {
        path = recorder!.play()
        let sender = Sender()
        sender.send(_path: path)
    }
    
    @IBAction func recordRecord(_ sender: UIButton) {
        recorder = Recorder()
        recorder.record()
    }
}

