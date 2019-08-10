//
//  ViewController.swift
//  PitchPerfect_AH
//
//  Created by Vahan's MBP on 8/7/19.
//  Copyright © 2019 Vahan's MBP. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        recorderLabel.text = "Tap to record"
    }
    
    var porcnakanPopoxutyun: String = "Porc"
    
    
    @IBOutlet weak var recorderLabel: UILabel!
    
    @IBOutlet weak var recorderButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    @IBAction func recorderTapped(_ sender: Any) {
        recorderButton.isEnabled = false
        pauseButton.isEnabled = true
        recorderLabel.text = "Recording in Progress"
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    

    @IBAction func pauseTapped(_ sender: Any) {
        recorderButton.isEnabled = true
        pauseButton.isEnabled = false
        recorderLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        if flag{
          performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("the recording is faild")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    
    
    
    
}

