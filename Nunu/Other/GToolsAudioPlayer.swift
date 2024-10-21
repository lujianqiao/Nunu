//
//  GToolsAudioPlayer.swift
//  Nunu
//
//  Created by lujianqiao on 2024/10/21.
//

import UIKit
import AVFoundation

class GToolsAudioPlayer: NSObject {

    public static let shared = GToolsAudioPlayer()
    
    var audioPlayer: AVAudioPlayer?
    
    func playAudioWithUrl(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 1.0
            audioPlayer?.prepareToPlay()
            
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
}
