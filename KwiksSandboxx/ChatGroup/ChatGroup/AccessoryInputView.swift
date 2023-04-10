//
//  AccessoryInputView.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit

class AccessoryInputView : UIView, UITextViewDelegate {
    
    var chatMain : ChatMain?,
        textViewYConstraint: NSLayoutConstraint?,
        textViewBottomConstraint: NSLayoutConstraint?,
        buttonInset: NSLayoutConstraint?,
        micInset: NSLayoutConstraint?,
        commentLeftAnchor : NSLayoutConstraint?
    
    lazy var commentTextView: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor .black.withAlphaComponent(0.4)
        tf.textColor =  .white
        tf.layer.masksToBounds = true
        tf.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        tf.delegate = self
        tf.returnKeyType = UIReturnKeyType.default
        tf.keyboardAppearance = UIKeyboardAppearance.default
        tf.isScrollEnabled = false
        tf.autocorrectionType = .yes
        tf.spellCheckingType = .yes
        tf.clipsToBounds = true
        tf.isUserInteractionEnabled = true
        tf.layer.shouldRasterize = false
        tf.layer.cornerRadius = 15
        tf.textAlignment = .left
        return tf
    }()
    
    lazy var addIcon : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFit
        let image = UIImage(named: "chat_plus_icon")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleAddIcon(sender:)), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let placeHolderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Type a message...."
        thl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = UIColor .white
        return thl
        
    }()
    
    lazy var microphoneRecordButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFit
        let image = UIImage(named: "chat_mini_mic_icon")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBeginAudioRecording(sender:)), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var cashButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFit
        let image = UIImage(named: "chat_wallet_icon")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleCashIcon(sender:)), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var sendButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFit
        let image = UIImage(named: "chat_send_icon")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleSendIcon(sender:)), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var recordBar : RecordBar = {
        
        let rb = RecordBar()
        rb.accessoryInputView = self
        
        return rb
    }()
    
    override var intrinsicContentSize: CGSize {
        return self.textViewContentSize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //accessory view config
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = .flexibleHeight
        self.sizeToFit()
        self.isUserInteractionEnabled = true
        self.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        
        //add the shadow to the top
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor .black.withAlphaComponent(0.1).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 25
        self.layer.shouldRasterize = false
        
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.commentTextView)
        self.addSubview(self.addIcon)
        self.addSubview(self.placeHolderLabel)
        self.addSubview(self.microphoneRecordButton)
        self.addSubview(self.cashButton)
        self.addSubview(self.sendButton)
        self.addSubview(self.recordBar)
        
        self.micInset = self.microphoneRecordButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22)
        self.micInset?.isActive = true
        self.microphoneRecordButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.microphoneRecordButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.microphoneRecordButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.cashButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.cashButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.cashButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonInset = self.cashButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        self.buttonInset?.isActive = true
        
        self.sendButton.rightAnchor.constraint(equalTo: self.cashButton.leftAnchor, constant: -10).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        self.sendButton.centerYAnchor.constraint(equalTo: self.cashButton.centerYAnchor).isActive = true
        
        self.commentTextView.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: -20).isActive = true
        self.textViewYConstraint = self.commentTextView.heightAnchor.constraint(equalToConstant: 35)
        self.textViewYConstraint?.isActive = true
        self.textViewBottomConstraint = self.commentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        self.textViewBottomConstraint?.isActive = true
        self.commentLeftAnchor = self.commentTextView.leftAnchor.constraint(equalTo: self.microphoneRecordButton.rightAnchor, constant: 5)
        self.commentLeftAnchor?.isActive = true
        self.commentTextView.layer.cornerRadius = 35/2
        
        self.commentTextView.textContainerInset = UIEdgeInsets(top: 11, left: 17, bottom: 5, right: 40)
        
        self.addIcon.rightAnchor.constraint(equalTo: self.commentTextView.rightAnchor, constant: 0).isActive = true
        self.addIcon.bottomAnchor.constraint(equalTo: self.commentTextView.bottomAnchor, constant: 2).isActive = true
        self.addIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.addIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.placeHolderLabel.leftAnchor.constraint(equalTo: self.commentTextView.leftAnchor, constant: 20).isActive = true
        self.placeHolderLabel.centerYAnchor.constraint(equalTo: self.commentTextView.centerYAnchor).isActive = true
        self.placeHolderLabel.rightAnchor.constraint(equalTo: self.addIcon.leftAnchor, constant: -10).isActive = true
        self.placeHolderLabel.sizeToFit()
        
        self.recordBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.recordBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.recordBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.recordBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func resetAfterSend() {
        self.commentTextView.text = ""
        UIView.animate(withDuration: 0.2) {
            self.textViewYConstraint?.constant = 35.0
            self.textViewBottomConstraint?.constant = 20.0
            self.chatMain?.heightConstraint?.constant = 60
            self.layoutIfNeeded()
            self.chatMain?.view.layoutIfNeeded()
            self.reloadInputViews()
        }
    }
    
    @objc func handleImagePickerButton(sender:UIButton) {
        self.chatMain?.handleImagePicker(sender:sender)
    }
    
    func updateHeight() {
        
        UIView.animate(withDuration: 0.4) {
            
            self.invalidateIntrinsicContentSize()
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
            
        } completion: { (complete) in }
    }
    
    //text height based on width ie. greatestFiniteMagnitude
    func textViewContentSize() -> CGSize {
        let size = CGSize(width: self.commentTextView.bounds.width,
                          height: CGFloat.greatestFiniteMagnitude)
        
        let textSize = self.commentTextView.sizeThatFits(size)
        return CGSize(width: bounds.width, height: textSize.height)
    }
    
    func shouldInvertText(should : Bool) {
        if should {
            self.commentTextView.backgroundColor = UIColor.commentBackgroundColor.withAlphaComponent(0.6)
            self.commentTextView.textColor = UIColor .black
        } else {
            self.commentTextView.backgroundColor = UIColor .black.withAlphaComponent(0.4)
            self.commentTextView.textColor = UIColor .white
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count <= 0 {
            
            self.placeHolderLabel.isHidden = false
            if self.chatMain?.isKeyboardShowing == false {
                self.microphoneRecordButton.isHidden = false
            }
            self.shouldInvertText(should: false)
            
        } else {
            self.microphoneRecordButton.isHidden = true
            self.placeHolderLabel.isHidden = true
            self.shouldInvertText(should: true)
        }
        
        if self.textViewYConstraint != nil {
            
            let contentHeight = textViewContentSize().height
            
            if self.textViewYConstraint!.constant != contentHeight {
                
                if self.textViewContentSize().height <= 35.0 {
                    self.textViewYConstraint!.constant = 35.0
                } else {
                    self.textViewYConstraint!.constant = self.textViewContentSize().height
                }
                self.chatMain?.heightConstraint?.constant = 25.0 + self.textViewContentSize().height
                
                self.layoutIfNeeded()
                self.chatMain?.reloadInputViews()
                self.chatMain?.view.layoutIfNeeded()
                
            }
        }
    }
    
    ///if in record mode, hide the ui and show the record bar
    func shouldBeRecording(hidden: Bool) {
        
        if hidden == true {
            UIView.animate(withDuration: 0.15) {
                self.recordBar.alpha = 1.0
            } completion: { complete in
                print("🟢 in record mode now")
            }
        } else {
            UIView.animate(withDuration: 0.15) {
                self.recordBar.alpha = 0.0
            } completion: { complete in
                print("🟡 finished recording")
            }
        }
    }
    
    @objc func handleSendButton(sender:UIButton) {
        self.chatMain?.handleSendButton(sender: sender)
    }
    
    @objc func handleBeginAudioRecording(sender:UIButton) {
        
        self.shouldBeRecording(hidden: true) //adjusts the UI - needs a new name
        self.recordBar.beginAudioRecording() //this starts the recording, call this elsewhere if needed
        
    }
    
    //this send a normal text message
    @objc func handleSendIcon(sender:UIButton) {
        
        guard let message = self.commentTextView.text else {return}
        let cleanMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        let messageCount = cleanMessage.count
        
        if messageCount > 0 {
            ///https call here with the clean message along with any other parameters required
            print("🟢 Message to send: \(cleanMessage)")
            self.resetAfterSend()
            
        }
    }
    
    //I have no idea what this does
    @objc func handleAddIcon(sender:UIButton) {
        self.chatMain?.handleAddIcon(sender:sender)
    }
    
    //this uses the wallet and sends money as it's own cell
    @objc func handleCashIcon(sender:UIButton) {
        self.chatMain?.handleCashButton(sender:sender)
    }
    
    //this is for the record bar trashcarn, scraps the recording
    @objc func handleTrashCan(sender:UIButton) {
        self.recordBar.finishRecording(fromTrashCan: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
