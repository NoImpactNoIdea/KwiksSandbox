//
//  RecordBar.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit

class RecordBar : UIView {
    
    var timeCounter: Int = 0
    
    var accessoryInputView : AccessoryInputView?
    
    var recordBar : UIView = {
        
        let rb = UIView()
        rb.translatesAutoresizingMaskIntoConstraints = false
        rb.backgroundColor = UIColor.recordGreen
        rb.isUserInteractionEnabled = false
        
        return rb
    }()
    
    let trashCanImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        let image = UIImage(named: "trashcan_button")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        
        return dcl
    }()
    
    let timerLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont(name: FontKit().segoeBold, size: 14)
        tl.textColor = UIColor .white
        tl.text = "00:00"
        tl.textAlignment = .right
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .orange
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.recordBar)
        self.addSubview(self.trashCanImage)
        self.addSubview(self.timerLabel)

        self.recordBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 28).isActive = true
        self.recordBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -28).isActive = true
        self.recordBar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        self.recordBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.recordBar.layer.cornerRadius = 35/2
        
        self.trashCanImage.centerYAnchor.constraint(equalTo: self.recordBar.centerYAnchor).isActive = true
        self.trashCanImage.leftAnchor.constraint(equalTo: self.recordBar.leftAnchor, constant: 6).isActive = true
        self.trashCanImage.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.trashCanImage.widthAnchor.constraint(equalToConstant: 23).isActive = true
//        self.trashCanImage.layer.cornerRadius = 23/2
        
        self.timerLabel.rightAnchor.constraint(equalTo: self.recordBar.rightAnchor, constant: -19).isActive = true
        self.timerLabel.centerYAnchor.constraint(equalTo: self.recordBar.centerYAnchor).isActive = true
        self.timerLabel.sizeToFit()

    }
    
    @objc func handleTimerCounter() {
        
        self.timeCounter += 1
        
        if self.timeCounter < 120 { //2 minute recordings here
            self.timerLabel.text = ConvertSecondsToHMS.secondsToHoursMinutesSeconds(seconds: self.timeCounter)
            
        } else {
            UIDevice.vibrateMedium()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ConvertSecondsToHMS : NSObject {
    
    static func secondsToHoursMinutesSeconds(seconds : Int) -> String {
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        var secondsString : String = ""
        var minutesString : String = ""
        var hoursString : String = ""
        
        //SECONDS
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        //MINUTES
        if hours < 10 {
            hoursString = "0\(hours)"
        } else {
            hoursString = "\(hours)"
        }
        
        //HOURS
        if minutes < 10 {
            minutesString = "0\(minutes)"
        } else {
            minutesString = "\(minutes)"
        }
        
        if hours < 1 {
            let timeString = "\(minutesString):\(secondsString)"
            return timeString
        } else {
            let timeString = "\(hoursString):\(minutesString):\(secondsString)"
            return timeString
        }
    }
}
