//
//  ChatExtensions.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit
import SDWebImage

//globals
var globalChatDataSource = [ChatModel]() //chat model reference

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
    var cancelIcon = "multiply"

    var bestiesLabel = "Besties"
    var familyLabel = "Family"
    var requestsLabel = "Requests"
    var archivedLabel = "Archived"
    var phone = "phone.fill"
    var video = "video"
    var ellipsis = "ellipsis"
    
    var background_chat_deep_pink = "background_chat_deep_pink"
    var background_chat_empty = "background_chat_empty"
    var background_chat_light_blue = "background_chat_light_blue"
    var background_chat_orange = "background_chat_orange"
    var background_chat_pink = "background_chat_pink"
    var background_chat_purple = "background_chat_purple"
    var background_chat_yellow = "background_chat_yellow"
    var chat_background_1 = "chat_background_1"

    var chat_backround_1 = "chat_background_1"
    var stockPhotoUrlBasicPattern = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fchat_backdrop_1%403x.png?alt=media&token=4299f7b8-ab38-4527-b29f-9ee03a728edd"
    var stockPhotoURLPattern = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fstock_wall_paper.jpg?alt=media&token=31989698-163b-4892-b8f1-aee5be2b4c56"
    var stockPhotoURLMusician = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fstock_musician.jpg?alt=media&token=d4894456-fd55-4896-99c9-5c6269f38f81"
    var stockPhotoURLWoman = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2FRectangle%2076%403x.png?alt=media&token=a2db3e30-1ab7-4226-aec9-f9e7f83d771f"
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

extension UIImageView {
    
    func loadImageGeneralUse(_ urlString: String, completion : @escaping (_ isComplete : Bool)->()) {
        
        self.image = UIImage()
        
        guard let url = URL(string: urlString) else {return}
        
        self.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground]) { (image, error, imageCacheType, imageUrl) in
            
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

var globalPhotoArray : [String] = ["\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)",
                             "\(S().stockPhotoURLPattern)"]



var background_chat_deep_pink = "background_chat_deep_pink"
var background_chat_empty = "background_chat_empty"
var background_chat_light_blue = "background_chat_light_blue"
var background_chat_orange = "background_chat_orange"
var background_chat_pink = "background_chat_pink"
var background_chat_purple = "background_chat_purple"
var background_chat_yellow = "background_chat_yellow"
var chat_background_1 = "chat_background_1"


var globalBackgroundArray : [String] = ["\(S().background_chat_empty)",
                             "\(S().background_chat_deep_pink)",
                             "\(S().background_chat_light_blue)",
                             "\(S().background_chat_orange)",
                             "\(S().background_chat_pink)",
                             "\(S().background_chat_purple)",
                             "\(S().background_chat_yellow)",
                             "\(S().chat_background_1)"]

func loadDummyData(completion : @escaping (_ isComplete : Bool, _ returnedBlock : [ChatModel])->()) {
    
    let one : [String : Any] = ["message" : "Hello Bernice 😅",
                                    "ownersProfilePhoto" : "\(S().stockPhotoURLWoman)",
                                    "ownersName" : "Charlie Arcodia",
                                    "timeStamp" : Date().timeIntervalSince1970,
                                    "audioClipUrl" : "url goes here",
                                    "messageTypeForDecision" : "message"
    ]
  
    let two : [String : Any] = ["message" : "John and James",
                                     "ownersProfilePhoto" : "\(S().stockPhotoURLMusician)",
                                     "ownersName" : "Charlie Arcodia",
                                     "timeStamp" : Date().timeIntervalSince1970,
                                     "audioClipUrl" : "url goes here",
                                     "messageTypeForDecision" : "audio"
    ]
    let three : [String : Any] = ["message" : "John and James",
                                     "ownersProfilePhoto" : "\(S().stockPhotoURLWoman)",
                                     "ownersName" : "Charlie Arcodia",
                                     "timeStamp" : Date().timeIntervalSince1970,
                                     "audioClipUrl" : "url goes here",
                                     "messageTypeForDecision" : "image"
    ]
    
    let four : [String : Any] = ["message" : "Whoa 🚀 Let's go!",
                                    "ownersProfilePhoto" : "\(S().stockPhotoURLMusician)",
                                    "ownersName" : "Charlie Arcodia",
                                    "timeStamp" : Date().timeIntervalSince1970,
                                    "audioClipUrl" : "url goes here",
                                    "messageTypeForDecision" : "message"
    ]
    
    let five : [String : Any] = ["message" : "Whoa 🚀 Let's go!",
                                    "ownersProfilePhoto" : "\(S().stockPhotoURLWoman)",
                                    "ownersName" : "Charlie Arcodia",
                                    "timeStamp" : Date().timeIntervalSince1970,
                                    "audioClipUrl" : "url goes here",
                                    "messageTypeForDecision" : "audio"
    ]
    let six : [String : Any] = ["message" : "Emojis -> 🤩🚀🤯👆🏽🐣💣💋",
                                    "ownersProfilePhoto" : "\(S().stockPhotoURLMusician)",
                                    "ownersName" : "Charlie Arcodia",
                                    "timeStamp" : Date().timeIntervalSince1970,
                                    "audioClipUrl" : "url goes here",
                                    "messageTypeForDecision" : "message"
    ]
    
    let seven : [String : Any] = ["message" : "Last message in the test collection 💪🏼",
                                    "ownersProfilePhoto" : "\(S().stockPhotoURLMusician)",
                                    "ownersName" : "Charlie Arcodia",
                                    "timeStamp" : Date().timeIntervalSince1970,
                                    "audioClipUrl" : "url goes here",
                                    "messageTypeForDecision" : "message"
    ]
    
    
let objOne = ChatModel(JSON: one),
    objTwo = ChatModel(JSON: two),
    objThree = ChatModel(JSON: three), //this is the image for testing - on hold though
    objFour = ChatModel(JSON: four),
    objFive = ChatModel(JSON: five),
    objSix = ChatModel(JSON: six),
    objSeven = ChatModel(JSON: seven),

    array = [objOne, objTwo, objFour, objFive, objSix, objSeven]
    globalChatDataSource = array
    completion(true, array)
}

