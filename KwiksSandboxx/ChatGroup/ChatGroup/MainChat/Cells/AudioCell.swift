//
//  AudioCell.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit
import Lottie

class AudioMainCell : UICollectionViewCell {
    
    var chatCollection : ChatCollection?
    
    var lottiAnimation : LottieAnimationView = {

        let lav = LottieAnimationView.init(name: "record_anim_2")
        lav.translatesAutoresizingMaskIntoConstraints = false
        lav.contentMode = .scaleAspectFill
        lav.layer.masksToBounds = true
        lav.clipsToBounds = true
        lav.loopMode = .loop
        lav.animationSpeed = 1.0
        lav.backgroundBehavior = .pauseAndRestore
        lav.isUserInteractionEnabled = true
       return lav
    }()
 
    let profilePhoto : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.profilePhotoBackgroundColor
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        
        return dcl
    }()
    
    let recordBubble : UIView = {
        
        let cb = UIView()
        cb.translatesAutoresizingMaskIntoConstraints = false
        cb.backgroundColor = UIColor.kwiksGreen
        cb.isUserInteractionEnabled = false
        cb.layer.masksToBounds = true
        cb.layer.cornerRadius = 15

        return cb
    }()
    
    let timeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "09:27 am"
        thl.font = UIFont(name: FontKit().segoeSemiBold, size: 10)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = UIColor.timeChatGrey
        thl.backgroundColor = .clear
        
        return thl
        
    }()
    
    let playPauseButton : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.white
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        let image = UIImage(named: "audio_pause_icon")?.withRenderingMode(.alwaysOriginal)
        dcl.setImage(image, for: .normal)
        
        return dcl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addViews()
        
        self.shouldAnimationBegin(shouldBegin: true)
    }
    
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.recordBubble)
        self.addSubview(self.timeLabel)
        self.addSubview(self.playPauseButton)
        self.addSubview(self.lottiAnimation)

        //this is the base line here
        self.timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.timeLabel.sizeToFit()
        
        self.profilePhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.profilePhoto.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -5).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.layer.cornerRadius = 25/2
       
        self.recordBubble.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.recordBubble.widthAnchor.constraint(equalToConstant: 158).isActive = true
        self.recordBubble.bottomAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 3).isActive = true
        self.recordBubble.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        self.playPauseButton.centerYAnchor.constraint(equalTo: self.recordBubble.centerYAnchor).isActive = true
        self.playPauseButton.leftAnchor.constraint(equalTo: self.recordBubble.leftAnchor, constant: 8).isActive = true
        self.playPauseButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        self.playPauseButton.widthAnchor.constraint(equalToConstant: 19).isActive = true
        self.playPauseButton.layer.cornerRadius = 19/2
        
        self.lottiAnimation.leftAnchor.constraint(equalTo: self.playPauseButton.rightAnchor, constant: 10).isActive = true
        self.lottiAnimation.rightAnchor.constraint(equalTo: self.recordBubble.rightAnchor, constant: -20).isActive = true
        self.lottiAnimation.topAnchor.constraint(equalTo: self.recordBubble.topAnchor, constant: 8).isActive = true
        self.lottiAnimation.bottomAnchor.constraint(equalTo: self.recordBubble.bottomAnchor, constant : -8).isActive = true

    }
    
    func shouldAnimationBegin(shouldBegin : Bool) {
        
        if shouldBegin {
            self.lottiAnimation.isHidden = false
            self.lottiAnimation.play { complete in
            }
        } else {
            self.lottiAnimation.isHidden = true
            self.lottiAnimation.currentTime = 0
            self.lottiAnimation.stop()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.recordBubble.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

