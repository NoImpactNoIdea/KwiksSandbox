//
//  ChatExtensions.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

extension UIDevice { //haptics and vibrations
    static func vibrateLight() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    static func vibrateMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    static func vibrateHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

struct S { //S for string
    var messages = "Messages"
    var backIcon = "back_icon_final"
    var newConvoIcon = "new_convo_icon"
    var magGlass = "mag_icon_header"
    var trashIcon = "trash_icon_white"
    var whitePinLargeTable = "white_pin_large_table"
    var messagePinIcon = "message_pin_icon"
    var threeDotsVertical = "three_dots_horizontal_icon"

    var bestiesLabel = "Besties"
    var familyLabel = "Family"
    var requestsLabel = "Requests"
    var archivedLabel = "Archived"
    var phone = "phone.fill"
    var video = "video"
    var ellipsis = "ellipsis"
}

extension CGFloat { //grab the status bar height
    func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
}

extension UILabel { //color parts of a string, set the default on the label then adjust the word/phrase with the parameters
    func colorFontString(text: String?, coloredText: String?, color: UIColor? = .red, fontName : String? = "Arial", fontSize : Double? = 13) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: UIFont(name: fontName!, size: fontSize!) as Any],
                                       range: range)
        
        self.attributedText = attributedString
    }
}

//countdown string time adjuster
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

//storing local audio files
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}


