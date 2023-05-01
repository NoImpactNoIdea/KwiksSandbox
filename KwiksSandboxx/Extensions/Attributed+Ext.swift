//
//  Attributed+Ext.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/24/23.
//

import Foundation
import UIKit

//image with text and font
class StringWithImageAndText : NSAttributedString {
    
    static let shared = StringWithImageAndText()
    
    func imageAndText(startingText: String, endingText: String, imageName : String, passedFont : UIFont, insets : UIEdgeInsets, textColor : UIColor, completion: @escaping (_ returnedAttribute : NSMutableAttributedString)->()) {
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: startingText)
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: imageName)?.imageWithSpacing(insets: insets)
        image1Attachment.bounds.size = CGSize(width: 20, height: 30)
        
        
        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        
        if endingText.count == 0 {
            fullString.append(NSAttributedString(string: "")) //add spacing between the icon and header
        } else {
            fullString.append(NSAttributedString(string: endingText))
        }
        
        let font = passedFont
        
        let length = startingText + endingText
        fullString.addAttributes([.font: font, .foregroundColor : textColor], range: NSRange(location: 0, length: length.count + image1String.length))
        
        completion(fullString)
    }
}


import Foundation
import UIKit

extension UIImage {
    func imageWithSpacing(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
