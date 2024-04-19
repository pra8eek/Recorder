//
//  PlaybackViewModel.swift
//  Recorder
//
//  Created by Prateek Bhardwaj on 03/04/24.
//

import Foundation
import AVFoundation
import CoreData
import SwiftUI

class PlaybackViewModel: NSObject, ObservableObject {
	private var audioPlayer: AVAudioPlayer?
	private var recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
	
	@Published var playingIndex = -1
	
	private let userDefaults = UserDefaults.standard
	private let recordingsKey = "recordings"
	
	@FetchRequest(
		sortDescriptors: []
	) var recordings: FetchedResults<AudioFiles>
	
	override init() {
		super.init()
	}
	
	public func isPlaying(index: Int) -> Bool {
		index == playingIndex
	}
	
	func playRecording(at url: URL) {
		do {
			try recordingSession.setCategory(.playback, mode: .default, options: [])
			try recordingSession.setActive(true)
			audioPlayer = try AVAudioPlayer(contentsOf: url )
			audioPlayer?.delegate = self
			audioPlayer?.play()
			
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}

extension PlaybackViewModel: AVAudioPlayerDelegate {
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		playingIndex = -1
		audioPlayer = nil
		
		// Deactivate the audio session after the audio finishes playing
		do {
			try recordingSession.setActive(false)
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}
