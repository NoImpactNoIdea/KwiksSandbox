//
//  BaseView.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/21/23.
//

import Foundation
import UIKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorKit().kwiksWhite
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
