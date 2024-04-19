//
//  RecordView.swift
//  Recorder
//
//  Created by Prateek Bhardwaj on 03/04/24.
//

import Foundation
import SwiftUI

struct RecordView: View {
	@ObservedObject private var viewModel = RecordingViewModel()
	@Environment(\.managedObjectContext) private var viewContext
	
	var body: some View {
		VStack {
			Button(action: {
				if viewModel.isRecording {
					viewModel.stopRecording(context: viewContext)
				} else {
					viewModel.startRecording()
				}
			}) {
				Text(viewModel.isRecording ? "Stop Recording" : "Start Recording")
			}
		}
	}
}
