// RecordingViewModel.swift
import Foundation
import AVFoundation
import CoreData

class RecordingViewModel: NSObject, ObservableObject {
	private var audioRecorder: AVAudioRecorder?
	private var recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
	private var fileURL: URL?
	
	private let userDefaults = UserDefaults.standard
	private let recordingsKey = "recordings"
	
	@Published var isRecording = false
	
	func startRecording() {
		let audioFilename = UUID().uuidString + ".m4a"
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		fileURL = documentsDirectory.appendingPathComponent(audioFilename)
		
		let settings: [String: Any] = [
			AVFormatIDKey: kAudioFormatAppleLossless,
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 2,
			AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
		]
		
		do {
			try recordingSession.setCategory(.playAndRecord, mode: .default, options: [])
			try recordingSession.setActive(true)
			audioRecorder = try AVAudioRecorder(url: fileURL!, settings: settings)
			audioRecorder?.record()
			isRecording = true
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
	
	func stopRecording(context: NSManagedObjectContext) {
		audioRecorder?.stop()
		isRecording = false
		if let url = fileURL {
			saveRecordings(url, context)
		}
		do {
			try recordingSession.setActive(false)
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
	
	private func saveRecordings(_ newRecording: URL, _ context: NSManagedObjectContext) {
		let audio = AudioFiles(context: context)
		audio.fileurl = newRecording
		try? context.save()
	}
}
