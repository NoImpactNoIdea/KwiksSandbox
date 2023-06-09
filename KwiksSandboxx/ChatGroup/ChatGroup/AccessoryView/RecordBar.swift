//
//  RecordBar.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit
import AVFoundation
import Lottie

class RecordBar : UIView, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var timeCounter: Int = 0,
        accessoryInputView : AccessoryInputView?,
        startVoiceNoteAudioPlayer = AVAudioPlayer(),
        audioRecorder: AVAudioRecorder!,
        audioTimer: Timer?,
        recordingSession: AVAudioSession!,
        isAudioEnabled: Bool = false,
        recordingTimeInSeconds: Int = 0
    
    var lottiAnimation : LottieAnimationView = {

        let lav = LottieAnimationView.init(name: "record_anim_2")
        lav.translatesAutoresizingMaskIntoConstraints = false
        lav.contentMode = .scaleAspectFill
        lav.layer.masksToBounds = true
        lav.clipsToBounds = true
        lav.loopMode = .loop
        lav.animationSpeed = 1.0
        lav.backgroundBehavior = .pauseAndRestore
        lav.isUserInteractionEnabled = true
       return lav
    }()

    lazy var recordBar : UIView = {
        
        let rb = UIView()
        rb.translatesAutoresizingMaskIntoConstraints = false
        rb.backgroundColor = UIColor.recordGreen
        rb.isUserInteractionEnabled = true
        return rb
    }()
    
    lazy var trashCanImage : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.clipsToBounds = true
        let image = UIImage(named: "trashcan_button")?.withRenderingMode(.alwaysOriginal)
        dcl.setImage(image, for: .normal)
        dcl.layer.zPosition = 100
        return dcl
    }()
    
    lazy var dummyTrashCanButton : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.layer.zPosition = 100
        return dcl
    }()
    
    let timerLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont(name: FontKit().segoeBold, size: 14)
        tl.textColor = UIColor .white
        tl.text = "00:00"
        tl.textAlignment = .right
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.isUserInteractionEnabled = true
        self.addViews()
        
        self.dummyTrashCanButton.addTarget(self.accessoryInputView, action: #selector(self.accessoryInputView?.handleTrashCan), for: .touchUpInside)
        
    }
    
    func addViews() {
        
        self.addSubview(self.recordBar)
        self.addSubview(self.trashCanImage)
        self.addSubview(self.lottiAnimation)
        self.addSubview(self.timerLabel)
        self.addSubview(self.dummyTrashCanButton)

        self.recordBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18).isActive = true
        self.recordBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18).isActive = true
        self.recordBar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        self.recordBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.recordBar.layer.cornerRadius = 35/2
        
        self.trashCanImage.centerYAnchor.constraint(equalTo: self.recordBar.centerYAnchor).isActive = true
        self.trashCanImage.leftAnchor.constraint(equalTo: self.recordBar.leftAnchor, constant: 6).isActive = true
        self.trashCanImage.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.trashCanImage.widthAnchor.constraint(equalToConstant: 23).isActive = true
        
        self.dummyTrashCanButton.topAnchor.constraint(equalTo: self.trashCanImage.topAnchor, constant: -10).isActive = true
        self.dummyTrashCanButton.leftAnchor.constraint(equalTo: self.trashCanImage.leftAnchor, constant: -10).isActive = true
        self.dummyTrashCanButton.rightAnchor.constraint(equalTo: self.trashCanImage.rightAnchor, constant: 10).isActive = true
        self.dummyTrashCanButton.bottomAnchor.constraint(equalTo: self.trashCanImage.bottomAnchor, constant: 10).isActive = true
        
        self.timerLabel.rightAnchor.constraint(equalTo: self.recordBar.rightAnchor, constant: -19).isActive = true
        self.timerLabel.centerYAnchor.constraint(equalTo: self.recordBar.centerYAnchor).isActive = true
        self.timerLabel.sizeToFit()
        
        self.lottiAnimation.leftAnchor.constraint(equalTo: self.trashCanImage.rightAnchor, constant: 10).isActive = true
        self.lottiAnimation.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -130).isActive = true
        self.lottiAnimation.topAnchor.constraint(equalTo: self.recordBar.topAnchor, constant: 8).isActive = true
        self.lottiAnimation.bottomAnchor.constraint(equalTo: self.recordBar.bottomAnchor, constant : -8).isActive = true

    }
    
    func shouldAnimationBegin(shouldBegin : Bool) {
        
        if shouldBegin {
            self.lottiAnimation.isHidden = false
            self.lottiAnimation.play { complete in
            }
        } else {
            self.lottiAnimation.isHidden = true
            self.lottiAnimation.currentTime = 0
            self.lottiAnimation.stop()
        }
    }
    
    @objc func beginAudioRecording() {
        
        self.requestAudioPermissions { isAuthroized in
            if isAuthroized {
                //has auth, init and start the timer
                self.initAudio()
                self.audioTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.handleTimerCounter), userInfo: nil, repeats: true)
                self.startRecording()
            } else {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
            }
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordBar {
    
    //begin recording, step 1 - init this guy
    @objc func initAudio() {
        self.startVoiceNoteAudioPlayer.delegate = self
        self.startVoiceNoteAudioPlayer.currentTime = 0.0
        self.startVoiceNoteAudioPlayer.play()
    }
    
    //permissions - sets the bool
    func requestAudioPermissions(completion : @escaping (_ isAuthroized : Bool)->()) {
        
        self.recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [])
            try recordingSession.setActive(true)
            self.recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.isAudioEnabled = true
                        completion(true)
                    } else {
                        self.isAudioEnabled = false
                        completion(false)
                        
                    }
                }
            }
        } catch {
            self.isAudioEnabled = false
            completion(false)
        }
    }
   
    
    @objc func handleTimerCounter() {
        
        self.timeCounter += 1
        
        if self.timeCounter < 120 { //2 minute recordings here
            self.timerLabel.text = ConvertSecondsToHMS.secondsToHoursMinutesSeconds(seconds: self.timeCounter)
        } else {
            UIDevice.vibrateMedium()
        }
    }
    
    //BEGIN RECORDING
    func startRecording() {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a") //this can be anything, just keep it the same
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.record()
            self.shouldAnimationBegin(shouldBegin: true)
            print("🎙 Recording in progress...")
        } catch {
            self.shouldAnimationBegin(shouldBegin: false)
            self.finishRecording(fromTrashCan: true)
        }
    }
    //default protocol. n Not necessary
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == false {
            print("Recording: Failed")
        } else {
            print("Recording: Suceeded")
        }
    }
    
    //call me to cancel and/or save
    func finishRecording(fromTrashCan : Bool) {
        print("everytime here")
        if self.audioRecorder != nil {
            print("everytime here 1")

            self.recordingTimeInSeconds = 0
            self.recordingTimeInSeconds = Int(self.audioRecorder.currentTime)
            self.audioRecorder = nil
            self.shouldAnimationBegin(shouldBegin: false)
            //only save if on purpose, if from trashcan route then negative
            if !fromTrashCan {
                self.storeDataForAudio()
            }
        } else {
            self.shouldAnimationBegin(shouldBegin: false)
            self.recordingTimeInSeconds = 0
        }
        
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.0
        }
        
        self.timerLabel.text = "00:00"
        self.timeCounter = 0
        self.startVoiceNoteAudioPlayer = AVAudioPlayer()
        self.audioRecorder = AVAudioRecorder()
        self.audioTimer?.invalidate()
        self.recordingSession = AVAudioSession()
        self.isAudioEnabled = false
        self.recordingTimeInSeconds = 0 //do I ruin the save below? Maybe wrap me under the trashcan parameter
        self.accessoryInputView?.dummyMicrophoneRecordButton.isHidden = false
    }
    
    //call me when you want to save the audio clip - the url and the duration is the meat, then metadata like user id, name etc.
    func storeDataForAudio() {
        
        //after recording has finished, call this function to grab the recording and save it
        let urlToUpload = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let recordingDuration = self.recordingTimeInSeconds
        print("Audio Recording: URL: \(urlToUpload) DURATION: \(recordingDuration)")
                
    }
    
    @objc func handleSaveAndSend() { //3 second minimum
        if self.timeCounter > 2 {
            self.finishRecording(fromTrashCan: false)
        } else {
            UIDevice.vibrateHeavy()
        }
    }
}

