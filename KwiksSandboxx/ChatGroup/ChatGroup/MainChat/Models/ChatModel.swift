//
//  ChatModel.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//
//

import Foundation

final class ChatModel : NSObject {
    
    enum TypeEnum {
        case message
        case audio
        case image
    }

    var typeEnum = TypeEnum.message
    
    var message : String?
    var ownersProfilePhoto : String?
    var ownersName : String?
    var timeStamp : Double = Date().timeIntervalSince1970
    var audioClipUrl : String?
    var messageTypeForDecision : String?
    var messageType : TypeEnum?

    init(JSON : [String : Any]) {
        super.init()
        
        self.message = JSON["message"] as? String ?? "nil"
        self.ownersProfilePhoto = JSON["ownersProfilePhoto"] as? String ?? "nil"
        self.ownersName = JSON["ownersName"] as? String ?? "nil"
        self.timeStamp = JSON["timeStamp"] as? Double ?? 0.0
        self.audioClipUrl = JSON["audioClipUrl"] as? String ?? "nil"
        self.messageTypeForDecision = JSON["messageTypeForDecision"] as? String ?? "nil"
        
        self.decide()
       
    }
    
    func decide() {
        
        switch self.messageTypeForDecision {
        case "message": self.typeEnum = .message
        case "audio": self.typeEnum = .audio
        case "image" : self.typeEnum = .image
        default: print("not a possible case")
        }
        
        self.messageType = typeEnum
    }
}
