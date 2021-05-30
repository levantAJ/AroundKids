//
//  SoundPlayer.swift
//  AroundKids
//
//  Created by Tai Le on 23/05/2021.
//

import AVFoundation

final class SoundPlayer {
    var player: AVAudioPlayer?

    func play(name: String, extensionName: String = "mp3") {
        guard let url: URL = Bundle.main.url(forResource: name, withExtension: extensionName) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch {
            print(error)
        }
    }
}
