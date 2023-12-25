//
//   SoundPlayer.swift
//  GameChallange
//
//  Created by sumaiya on 21/12/2566 BE.
//

import Foundation
import AVFoundation

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?

     func playSound(named fileName: String, fileType: String = "mp3") {
         guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
             print("Error: Sound file '\(fileName).\(fileType)' not found.")
             return
         }

         playSound(from: url)
     }

     func playSound(from url: URL) {
         do {
             audioPlayer = try AVAudioPlayer(contentsOf: url)
             audioPlayer?.prepareToPlay()
             audioPlayer?.play()
         } catch let error as NSError {
             print("Error loading sound file '\(url.lastPathComponent)': \(error.localizedDescription)")
             audioPlayer = nil
         }
     }
 

}
