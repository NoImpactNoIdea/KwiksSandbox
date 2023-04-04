//
//  ErrorHandler.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 3/21/23.
//

/*
 This class calls a custom popup
 that is iconable, copyable and
 buttonable
 */

//TODO: - FINALIZE AND WRAP
import Foundation
import UIKit
//error handling enum
public enum ErrorHandler{
    case NoInternetConnection
    case SomethingWentWrong
    case AccountSuspended
    case LoginFailed
    case AppLocked
    case VideoUploadFailed
    case FileNotSupported
    case PostingVideoError
    case SoundNotWorking
    case UploadFailed
    case PaymentDeclined
    case CreditCardNotSupported
    case InsufficientBalanceBoostingVideos
    case InsufficientBalanceWithdrawBalance
    case ReportBlock
    case GiveFeedBack
    case ReportAProblem
}

class KwiksAlert : UIView {
    
    var dynamicPopUpContainer : UIView = {
        let dpp = UIView()
        dpp.translatesAutoresizingMaskIntoConstraints = true
        dpp.backgroundColor = UIColor .white //TODO: CHANGE ME TO YOUR GLOBAL COLOR
        dpp.isUserInteractionEnabled = true
        dpp.layer.cornerRadius = 25
        dpp.layer.masksToBounds = true
       return dpp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //UIScreen.Main is deprecated for iOS 16 - using the scene window instead - //TODO: actually make these constants global
        guard let screenHeight = self.window?.windowScene?.screen.bounds.height else {return}
        guard let screenWidth = self.window?.windowScene?.screen.bounds.width  else {return}
               
        //always takes the device height and width for the smokescreen
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = UIColor (white: 0.8, alpha: 0.45)
        self.isUserInteractionEnabled = true
        self.alpha = 0.0
        
        //popups should always be dismissable from outside target taps
        let down = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissPopUp))
        down.direction = .down
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissPopUp))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissPopUp))
        right.direction = .right
        
        self.addGestureRecognizer(down)
        self.addGestureRecognizer(left)
        self.addGestureRecognizer(right)
        
        self.addViews(screenWidth: screenWidth)

    }
    
    func addViews(screenWidth : CGFloat) {
        self.addSubview(self.dynamicPopUpContainer)
        //needs to be centerd with 40 points from both sides - take into account
        self.dynamicPopUpContainer.frame = CGRect(x: 0, y: 0, width: screenWidth - CGFloat(80.0), height: 30.0)
    }
    
    @objc func engagePopup() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.alpha = 1.0
        } completion: { complete in
            debugPrint("🟢 POPUP PRESENTED")
        }
    }
    
    @objc func dismissPopUp() {
        //animate the popup down as the background is fading, then actionable event if should follow
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.alpha = 0.0
        } completion: { complete in
            debugPrint("🟢 POPUP DISMISSED")
        }
    }
    
    func handlePopup() {
        
        //should start from the bottom of the screen
        //should stop when centered, micro animation here
        //should present with all features in the correct size, should not scale as it's presenting
        //call to action - how to send to the approproiate place? Protocol would work here
        //one line call to execution
        
        //step 1 - dynamic height, build to the smallest size as the base then expand based on content inside
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
