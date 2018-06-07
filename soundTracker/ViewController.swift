//
//  ViewController.swift
//  soundTracker
//
//  Created by cplayer on 2018/4/19.
//  Copyright © 2018年 cplayer. All rights reserved.
//

import UIKit
import Kronos
import Material
import CoreMotion

//struct ButtonLayout {
//    struct Flat {
//        static let width: CGFloat = 120
//        static let height: CGFloat = 44
//        static let offsetY: CGFloat = -150
//    }
//
//    struct Raised {
//        static let width: CGFloat = 150
//        static let height: CGFloat = 44
//        static let offsetY: CGFloat = -75
//    }
//
//    struct Fab {
//        static let diameter: CGFloat = 48
//    }
//
//    struct Icon {
//        static let width: CGFloat = 120
//        static let height: CGFloat = 48
//        static let offsetY: CGFloat = 75
//    }
//}

class ViewController: UIViewController {
    
    // mute system card
    fileprivate var card: Card!
    
    fileprivate var toolbar: Toolbar!
    fileprivate var moreButton: IconButton!
    
    fileprivate var contentView: UILabel!
    
    fileprivate var bottomBar: Bar!
    fileprivate var dateFormatter: DateFormatter!
    fileprivate var dateLabel: UILabel!
    fileprivate var favoriteButton: IconButton!
    
    fileprivate var setLocationButton: IconButton!
    
    // for play music card
    fileprivate var cardPlayMusic: Card!
    
    fileprivate var toolbarPlayMusic: Toolbar!
    fileprivate var moreButtonPlayMusic: IconButton!
    
    fileprivate var contentViewPlayMusic: UILabel!
    
    fileprivate var bottomBarPlayMusic: Bar!
//    fileprivate var dateFormatterP: DateFormatter!
    fileprivate var dateLabelPlayMusic: UILabel!
//    fileprivate var favoriteButton: IconButton!
    fileprivate var setLocationButtonPlayMusic: IconButton!
    
    // for recording sound
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
        
        prepareSwitch()
        prepareDateFormatter()
        prepareDateLabel()
        prepareSetLocationButton()
        //prepareFavoriteButton()
        prepareMoreButton()
        prepareToolbar()
        prepareContentView()
        prepareBottomBar()
        prepareCard()
        
        //        prepareFlatButton()
        //        prepareRaisedButton()
        //        prepareFABButton()
        //        prepareIconButton()
        
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
        //        let urlString = "http://maps.google.com"
        //        if let url = URL(string: urlString) {
        //            //根据iOS系统版本，分别处理
        //            if #available(iOS 10, *) {
        //                UIApplication.shared.open(url, options: [:],
        //                                          completionHandler: {
        //                                            (success) in
        //                })
        //            } else {
        //                UIApplication.shared.openURL(url)
        //            }
        //        }
    }
    
    // SetLocationButton -> set action for current location
    @objc func setLocationMuteSystem() {
        recorder = Recorder()
        recorder.record()
    }
    
    @objc func setLocationPlayMusic() {
        recorder = Recorder()
        recorder.record()
    }
    
}


extension ViewController {
    
    fileprivate func prepareSwitch() {
        let control = Switch(state: .off, style: .light, size: .small)
        control.delegate = self
        
        view.layout(control).horizontally(left: 20, right: 20).bottom(50)
    }
    
    fileprivate func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    fileprivate func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.grey.base
        dateLabel.text = dateFormatter.string(from: Date.init())
        
        dateLabelPlayMusic = UILabel()
        dateLabelPlayMusic.font = RobotoFont.regular(with: 12)
        dateLabelPlayMusic.textColor = Color.grey.base
        dateLabelPlayMusic.text = dateFormatter.string(from: Date.init())
    }
    
    fileprivate func prepareSetLocationButton() {
        setLocationButton = IconButton(image: Icon.cm.settings, tintColor: Color.blueGrey.base)
        setLocationButton.addTarget(self, action: #selector(setLocationMuteSystem), for: UIControlEvents.touchUpInside)
        
        setLocationButtonPlayMusic = IconButton(image: Icon.cm.settings, tintColor: Color.blueGrey.base)
        setLocationButtonPlayMusic.addTarget(self, action: #selector(setLocationPlayMusic), for: UIControlEvents.touchUpInside)
    }
    
    fileprivate func prepareFavoriteButton() {
        favoriteButton = IconButton(image: Icon.favorite, tintColor: Color.red.base)
    }
    
    fileprivate func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical, tintColor: Color.grey.base)
        
        moreButtonPlayMusic = IconButton(image: Icon.cm.moreVertical, tintColor: Color.grey.base)
    }
    
    fileprivate func prepareToolbar() {
        toolbar = Toolbar(rightViews: [moreButton])
        
        toolbar.title = "Mute System"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Activated when you're asleep."
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        // for play music card
        toolbarPlayMusic = Toolbar(rightViews: [moreButtonPlayMusic])
        toolbarPlayMusic.title = "Play Music"
        toolbarPlayMusic.titleLabel.textAlignment = .left
        toolbarPlayMusic.detail = "Activated at some specific place."
        toolbarPlayMusic.detailLabel.textAlignment = .left
        toolbarPlayMusic.detailLabel.textColor = Color.grey.base
    }
    
    fileprivate func prepareContentView() {
        contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = "Set the location of your iPhone close to (x, y) and then it will be muted automatically."
        contentView.font = RobotoFont.regular(with: 14)
        
        //for play music card
        contentViewPlayMusic = UILabel()
        contentViewPlayMusic.numberOfLines = 0
        contentViewPlayMusic.text = "Set the location of your iPhone close to (x, y) and then it will play music for you!"
        contentViewPlayMusic.font = RobotoFont.regular(with: 14)
    }
    
    fileprivate func prepareBottomBar() {
        bottomBar = Bar()
        
//        bottomBar.leftViews = [favoriteButton]
        bottomBar.leftViews = [setLocationButton]
        bottomBar.rightViews = [dateLabel]
//        bottomBar.centerViews = [setLocationButton]
        
        // for Play Music Card
        bottomBarPlayMusic = Bar()
        bottomBarPlayMusic.leftViews = [setLocationButtonPlayMusic]
        bottomBarPlayMusic.rightViews = [dateLabelPlayMusic]
    }
    
    fileprivate func prepareCard() {
        card = Card()
        
        card.toolbar = toolbar
        card.toolbarEdgeInsetsPreset = .square3
        card.toolbarEdgeInsets.bottom = 0
        card.toolbarEdgeInsets.right = 8
        
        card.contentView = contentView
        card.contentViewEdgeInsetsPreset = .wideRectangle3
        
        card.bottomBar = bottomBar
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        view.layout(card).horizontally(left: 20, right: 20).top(80)
        
        // for play music card
        cardPlayMusic = Card()
        cardPlayMusic.toolbar = toolbarPlayMusic
        cardPlayMusic.toolbarEdgeInsetsPreset = .square3
        cardPlayMusic.toolbarEdgeInsets.bottom = 0
        cardPlayMusic.toolbarEdgeInsets.right = 8
        cardPlayMusic.contentView = contentViewPlayMusic
        cardPlayMusic.contentViewEdgeInsetsPreset = .wideRectangle3
        cardPlayMusic.bottomBar = bottomBarPlayMusic
        cardPlayMusic.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        view.layout(cardPlayMusic).horizontally(left: 20, right: 20).top(250)
    }
}

extension ViewController: SwitchDelegate {
    func switchDidChangeState(control: Switch, state: SwitchState) {
        print("Switch changed state to: ", .on == state ? "on" : "off")
    }
}


//extension ViewController {
//    fileprivate func prepareFlatButton() {
//        let button = FlatButton(title: "Flat Button")
//
//        view.layout(button)
//            .width(ButtonLayout.Flat.width)
//            .height(ButtonLayout.Flat.height)
//            .center(offsetY: ButtonLayout.Flat.offsetY)
//    }
//
//    fileprivate func prepareRaisedButton() {
//        let button = RaisedButton(title: "Raised Button", titleColor: .white)
//        button.pulseColor = .white
//        button.backgroundColor = Color.blue.base
//
//        view.layout(button)
//            .width(ButtonLayout.Raised.width)
//            .height(ButtonLayout.Raised.height)
//            .center(offsetY: ButtonLayout.Raised.offsetY)
//    }
//
//    fileprivate func prepareFABButton() {
//        let button = FABButton(image: Icon.cm.add, tintColor: .white)
//        button.pulseColor = .white
//        button.backgroundColor = Color.red.base
//
//        view.layout(button)
//            .width(ButtonLayout.Fab.diameter)
//            .height(ButtonLayout.Fab.diameter)
//            .center()
//    }
//
//    fileprivate func prepareIconButton() {
//        let button = IconButton(image: Icon.cm.search)
//
//        view.layout(button)
//            .width(ButtonLayout.Icon.width)
//            .height(ButtonLayout.Icon.height)
//            .center(offsetY: ButtonLayout.Icon.offsetY)
//    }
//}
