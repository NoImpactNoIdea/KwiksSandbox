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
    var backIcon = "chevron.left"
    var plusSquare = "plus.square"
    var magGlass = "magnifyingglass"
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

extension UILabel {
    func colorFontString(text: String?, coloredText: String?, color: UIColor? = .red, fontName : String? = "Arial", fontSize : Double? = 13) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: UIFont(name: fontName!, size: fontSize!) as Any],
                                       range: range)
        
        self.attributedText = attributedString
    }
}


