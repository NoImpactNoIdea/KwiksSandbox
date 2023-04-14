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

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

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

extension UITextField {
    func setupLeftImage(imageName: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 37.5, height: 40))
        imageContainerView.addSubview(imageView)
        
        self.leftView = imageContainerView
        self.leftViewMode = .always
        self.tintColor = .black
    }
}

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide, _ imageName : String) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true

        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
            imageView.image = UIImage(named: imageName)?.withTintColor(UIColor.chatTextGrey)
            
            let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 37.5, height: 40))
            imageContainerView.addSubview(imageView)
            
            self.leftView = imageContainerView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

struct S { //S for string - apparently noone does this :)
    var messages = "Messages"
    var backIcon = "back_icon_final"
    var longBackIcon = "long_back_arrow"
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
    
    var manOne = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fman-g8ca04b58b_1920.jpg?alt=media&token=57e88789-73a1-409d-9606-bdb34e2834b4"
    
    var womanOne = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fwoman-gf9670cc7c_1920.jpg?alt=media&token=d06975a3-ef9b-41f6-8ea5-b0676b62dc8a"
    
    var womanTwo = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fpopart-gdc9880353_1920.jpg?alt=media&token=9537d091-f985-43b0-ba3a-3c167d40a009"
    
    var womanThree = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fgirl-gbad346c14_1920.jpg?alt=media&token=054ae85b-7e3a-4d12-b9ea-0897ad6c56df"
    
    var womanFour = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fhip-hop-g91249a87e_1280.jpg?alt=media&token=a817ed22-01a1-40ae-8d5b-725561564a0d"
    
    var womanFive = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fdrew-colins-LIEQsu5JuoM-unsplash.jpg?alt=media&token=521625a5-da23-4e0d-9eb5-101a2f284ec0"
    
    var womanSix = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fhanson-lu-PhzM4ABsTiQ-unsplash.jpg?alt=media&token=789eeca9-e8fd-4e66-b834-570e854937fb"
    
    var womanSeven = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fdance-ga83f954ca_1920.jpg?alt=media&token=a352e3ee-6e18-4df5-8cdf-833e5e7f7e52"
    
    var womanEight = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fholi-gac431fd4d_1920.jpg?alt=media&token=d3b18e74-a081-4809-b3f6-42c73fa94d9f"
    
    var manTwo = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fexpensive-ge11e5c445_1920.jpg?alt=media&token=2e7eecf1-b769-4506-9cb3-a38ddb9b81d7"
    
    var manThree = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Fadult-g519c41b5b_1920.jpg?alt=media&token=6a084723-ec79-4386-b9a9-e1d42128279a"
    
    var manFour = "https://firebasestorage.googleapis.com/v0/b/matcher-client-prod.appspot.com/o/dummy_photos%2Frap-g8604c2bd4_1280.jpg?alt=media&token=45913266-76e5-4070-88b7-ab406f52936c"
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

var globalPhotoArray : [String] = ["\(S().womanEight)",
                             "\(S().manOne)",
                             "\(S().womanOne)",
                             "\(S().manTwo)",
                             "\(S().womanTwo)",
                             "\(S().manThree)",
                             "\(S().womanFive)",
                             "\(S().womanFour)",
                             "\(S().manFour)",
                             "\(S().womanSeven)",
                             "\(S().womanThree)",
                             "\(S().womanSix)"
]

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
    objThree = ChatModel(JSON: three), 
    objFour = ChatModel(JSON: four),
    objFive = ChatModel(JSON: five),
    objSix = ChatModel(JSON: six),
    objSeven = ChatModel(JSON: seven),

    array = [objOne, objTwo, objFour, objFive, objSix, objSeven]
    globalChatDataSource = array
    completion(true, array)
}

