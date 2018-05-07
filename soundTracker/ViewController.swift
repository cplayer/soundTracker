//
//  ViewController.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var recorder : Recorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // let sender = Sender()
        // sender.send()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playRecord(_ sender: UIButton) {
        recorder!.play()
    }
    
    @IBAction func recordRecord(_ sender: UIButton) {
        recorder = Recorder()
        recorder.record()
    }
}

