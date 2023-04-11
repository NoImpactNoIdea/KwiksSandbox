//
//  ChatMain.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

class ChatMain : UIViewController {
    
    var canBecomeResponder: Bool = true,
        heightConstraint: NSLayoutConstraint?,
        isKeyboardShowing : Bool = false,
        shouldAdjustForKeyboard : Bool = false
    
    var chatDataSource = [ChatModel]()
    
    lazy var chatHeader : ChatHeader = {
        
        let ch = ChatHeader()
        ch.chatMain = self
        
        return ch
    }()
    
    lazy var interiorHeader : InteriorHeader = {
        
        let ch = InteriorHeader()
        ch.chatMain = self
        
        return ch
    }()
    
    lazy var chatCollection : ChatCollection = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cm = ChatCollection(frame: .zero, collectionViewLayout: layout)
        cm.chatMain = self
        
       return cm
    }()
    
    lazy var requestView : RequestView = {
        
        let ch = RequestView()
        ch.chatMain = self
        ch.alpha = 0.0
        
        return ch
    }()
    
    lazy var customInputAccessoryView: AccessoryInputView = {
        let cia = AccessoryInputView()
        cia.chatMain = self
        cia.alpha = 1.0
        return cia
    }()
    
    //MARK: - BEGIN ACCESSORY STUBS
    override var canBecomeFirstResponder: Bool {
        return self.canBecomeResponder
    }
    
    override var inputAccessoryView: UIView? {
        return self.customInputAccessoryView
    }
    //MARK: - END ACCESSORY STUBS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor .white
        self.addViews() //ui
        self.handleObservers() //listeners - keyboard
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadDummyData() //replace this with the datasource
        self.chatDataSource = globalChatDataSource //global
        self.loadDummyData()
    }
    
    //garbage and memory cleanup
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.shouldAdjustForKeyboard = true //this happens with overviews on the same controller
        self.showFirstResponder()
        self.chatCollection.scrollToBottom(animated: true)

    }
    
    func addViews() {
        
        self.view.addSubview(self.chatHeader)
        self.view.addSubview(self.chatCollection)
        self.view.addSubview(self.customInputAccessoryView)
        self.view.addSubview(self.requestView)
        
        self.chatCollection.addSubview(self.interiorHeader)
        
        self.interiorHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.interiorHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.interiorHeader.bottomAnchor.constraint(equalTo: self.chatCollection.topAnchor, constant : -17).isActive = true
        self.interiorHeader.heightAnchor.constraint(equalToConstant: 200).isActive = true

        self.chatHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.chatHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.chatHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.chatHeader.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        self.chatCollection.topAnchor.constraint(equalTo: self.chatHeader.bottomAnchor, constant: -105).isActive = true
        self.chatCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.chatCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.chatCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.requestView.topAnchor.constraint(equalTo: self.chatCollection.topAnchor).isActive = true
        self.requestView.leftAnchor.constraint(equalTo: self.chatCollection.leftAnchor).isActive = true
        self.requestView.rightAnchor.constraint(equalTo: self.chatCollection.rightAnchor).isActive = true
        self.requestView.bottomAnchor.constraint(equalTo: self.chatCollection.bottomAnchor).isActive = true
        
        self.heightConstraint = self.customInputAccessoryView.heightAnchor.constraint(equalToConstant: 60)
        self.heightConstraint?.isActive = true
        self.customInputAccessoryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.customInputAccessoryView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.customInputAccessoryView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        //toggle me to show the normal chat or the request view with accepts etc.
        self.toggleRequestView(shouldShow: false)
        
    }
    
    func loadDummyData() {
        
        DispatchQueue.main.async {
            
            //dummy info to delete and dynamically fill
            let stock_image = UIImage(named: "stock_photo_man")?.withRenderingMode(.alwaysOriginal)
            self.chatHeader.statusLabel.text = "Online"
            self.chatHeader.nameLabel.text = "Charlie Arcodia"
            self.chatHeader.profilePhoto.image = stock_image
            
        }
        
        DispatchQueue.main.async {
            self.chatCollection.reloadData()
            self.chatCollection.scrollToBottom(animated: true)
        }
    }
    
    @objc func toggleRequestView(shouldShow : Bool) { //also pass in the datasrouce
        
        if shouldShow {
            self.customInputAccessoryView.alpha = 0.0
            self.requestView.alpha = 1.0
        } else {
            self.requestView.alpha = 0.0
            self.customInputAccessoryView.alpha = 1.0
        }
    }
 
    @objc func handleBackButton() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true) //i suppose this could be presented also, need a decision
        } else {
            self.dismiss(animated: true)
        }
    }
    
    //MARK: function calls from accessory view
    @objc func handleSendButton(sender:UIButton) {
        UIDevice.vibrateLight()
        print(#function)
    }
    @objc func handleImagePicker(sender:UIButton) {
        UIDevice.vibrateLight()
        print(#function)
    }
    @objc func handleBeginAudioRecording(sender:UIButton) {
        UIDevice.vibrateLight()
     
    }
    @objc func handleCashButton(sender:UIButton) {
        UIDevice.vibrateLight()

        print(#function)
    }
    @objc func handleAddIcon(sender:UIButton) {
        UIDevice.vibrateLight()
        print(#function)
    }
}

//accessory view manager
extension ChatMain {
    
    //MARK: - KEYBOARD LISTENER
    func handleObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - KEYBOARD PRESENTATION
    @objc func handleKeyboardShow(notification : Notification) {
        
        self.adjustContentForKeyboard(shown: true, notification: notification as NSNotification)
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        if keyboardRectangle.height > 200 {
            if self.isKeyboardShowing == true {return}
            self.isKeyboardShowing = true
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.customInputAccessoryView.textViewBottomConstraint?.constant = -12.5
                self.customInputAccessoryView.buttonInset?.constant = -12.5
                self.customInputAccessoryView.micInset?.constant = -12.5
                self.customInputAccessoryView.commentLeftAnchor?.constant = -25
                self.customInputAccessoryView.microphoneRecordButton.isHidden = true
                self.customInputAccessoryView.dummyMicrophoneRecordButton.isHidden = true
                self.customInputAccessoryView.updateHeight()
                self.customInputAccessoryView.updateConstraints()
            } completion: { complete in
                print("up")
            }
        }
    }
    
    //MARK: - KEYBOARD DISMISS
    @objc func handleKeyboardHide(notification : Notification) {
        
        self.isKeyboardShowing = false
        
        self.adjustContentForKeyboard(shown: false, notification: notification as NSNotification)
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.customInputAccessoryView.textViewBottomConstraint?.constant = -20
            self.customInputAccessoryView.buttonInset?.constant = -20
            self.customInputAccessoryView.micInset?.constant = -22
            self.customInputAccessoryView.commentLeftAnchor?.constant = 5
            self.customInputAccessoryView.microphoneRecordButton.isHidden = false
            self.customInputAccessoryView.dummyMicrophoneRecordButton.isHidden = false
            self.customInputAccessoryView.updateHeight()
            self.customInputAccessoryView.updateConstraints()
        } completion: { complete in
            print("up")
        }
    }
    
    //MARK: - CONTENT ADJUSTMENT
    func adjustContentForKeyboard(shown: Bool, notification: NSNotification) {
        
        //MARK: - KEYBOARD HEIGHT
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        //MARK: - KEYBOARD DURATION
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        
        //MARK: - KEYBOARD FRAME
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let _ = notification.userInfo![frameKey] as! NSValue
        
        //MARK: - KEYBOARD CURVE
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let _ = UIView.AnimationCurve(rawValue: curveValue)!
        
        guard shouldAdjustForKeyboard else { return }
        
        let keyboardHeight = shown ? keyboardRectangle.height : self.customInputAccessoryView.frame.height
        if self.chatCollection.contentInset.bottom == keyboardHeight {
            return
        }
        
        let distanceFromBottom = self.chatCollection.bottomOffset().y - self.chatCollection.contentOffset.y
        
        var insets = self.chatCollection.contentInset
        insets.bottom = keyboardHeight + 5.0
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            
            self.chatCollection.contentInset = insets
            self.chatCollection.scrollIndicatorInsets = insets
            
            if distanceFromBottom < 100 {
                self.chatCollection.contentOffset = self.chatCollection.bottomOffset()
            }
        }, completion: nil)
    }
    
    //MARK: - SHOWS THE ACCESSORY VIEW
    @objc func showFirstResponder() {
        if !self.customInputAccessoryView.commentTextView.isFirstResponder {
            self.customInputAccessoryView.isHidden = false
            self.canBecomeResponder = true
            self.becomeFirstResponder()
            self.reloadInputViews()
            self.customInputAccessoryView.reloadInputViews()
        } else {
            self.customInputAccessoryView.isHidden = false
            self.canBecomeResponder = true
            self.becomeFirstResponder()
            self.reloadInputViews()
            self.customInputAccessoryView.reloadInputViews()
            
        }
    }
    
}
