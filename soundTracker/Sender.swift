//
//  Sender.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import Foundation
import Alamofire

class Sender {
    func send (_path : String?) {
        // url需要随时修改
        let url = "http://181.215.102.4:8080/uploadSound"
        // let path = Bundle.main.path(forResource: "record", ofType: "wav")
        let path = _path
        // let data = try? Data.init(referencing: NSData.init(contentsOfFile: path!))
        let data = try? Data.init(contentsOf: URL(fileURLWithPath: path!))
        print("Uploading!...")
        Alamofire.upload(
            multipartFormData: { (multipartData) in
                multipartData.append(data!, withName: "file", fileName: "record.wav", mimeType: "audio/x-wav")
            }, to: url,
            encodingCompletion: { (encodingResult) in
                switch (encodingResult) {
                case .success (let upload, _, _):
                    print("Uploading Success!")
                    upload.responseJSON(completionHandler: { (response) in
                        print(String(data: response.data!, encoding: .utf8)!)
                    })
                case .failure (let error):
                    print("Error in Uploading!")
                    print(error)
                }
            }
        )
    }
}
