//
//  ColorSheet.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 3/31/23.
//

import Foundation
import UIKit

extension UIColor {
  /// #E1E1E1
  static let borderGrey = UIColor(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)

  /// #9AE769
  static let kwiksGreen = UIColor(red: 0.6039215686, green: 0.9058823529, blue: 0.4117647059, alpha: 1)

  /// #BCBCBC
  static let tabBarGrey = UIColor(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)

  /// #D9D9D9
  static let kwiksGrey = UIColor(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)

  /// #3A3A3A
  static let kwiksTextBlack = UIColor(red: 0.2274509804, green: 0.2274509804, blue: 0.2274509804, alpha: 1)

  /// #171717
  static let kwiksBackgroundBlack = UIColor(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)

  /// #A6A6A6
  static let musicTextColor = UIColor(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 1)
    
  /// #797979
  static let unSelectedTextColor = UIColor(hex: 0x797979)
    
  /// #686868
  static let chatTextGrey = UIColor(hex: 0x686868)
    
  /// #D1D1D6
  static let dividerLineGrey = UIColor(hex: 0xD1D1D6)
    
  /// #80C554
  static let kwiksDeepGreen = UIColor(hex: 0x80C554)

  /// #35353D
  static let kwiksMatteBlack = UIColor(hex: 0x35353D)

  /// #757575
  static let fontBrown = UIColor(hex: 0x757575)

  /// #565656
  static let iconBrown = UIColor(hex: 0x565656)
    
  /// #FAFAFA
  static let requestGrey = UIColor(hex: 0xFAFAFA)
    
  /// #FC9F9F
  static let blockRed = UIColor(hex: 0xFC9F9F)

  ///DADADA
  static let deleteGrey = UIColor(hex: 0xDADADA)

  ///2D2D2D
  static let headerBlack = UIColor(hex: 0x2D2D2D)
    
  ///E5F4DB
  static let pinLightGreen = UIColor(hex: 0xE5F4DB)

  ///060D05
  static let differentShadeBlack = UIColor(hex: 0x060D05)
    
  ///DFDFDF
  static let commentBackgroundColor = UIColor(hex: 0xDFDFDF)
   
  ///FF1A1A
  static let trashCanRed = UIColor(hex: 0xFF1A1A)
    
  ///8BD95A
  static let recordGreen = UIColor(hex: 0x8BD95A)
    
  static let profilePhotoBackgroundColor = UIColor (white: 0.8, alpha: 0.4)
    
  static let timeChatGrey = UIColor(hex: 0xBBBBBB)
    
  static let buttonGreyChat = UIColor(hex: 0xF6F6F6)
    
  static let anotherMatteBlack = UIColor(hex: 0x292C30)
    
  static let selectorBackgroundColor = UIColor(hex: 0xF2F2F2)
    
  static let searchWhite = UIColor(hex: 0xF6F6F6)

    
    

}

//HEX Color value
extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
        
    }
}

//colorkit
struct ColorKit {
    
    static let shared = ColorKit()
    static var kwiksGreen = UIColor(hex: 0x9AE769)
    
}

//bundled fonts
struct FontKit {
    
    static let shared = FontKit()
    
    let segoeRegular = "SegoeUI",
        segoeRegularItalic = "SegoeUI-Italic",
        segoeSemiBold = "SegoeUI-Semibold",
        segoeBold = "SegoeUI-Bold",
        segoeBoldItalic = "SegoeUI-BoldItalic"
    
}
