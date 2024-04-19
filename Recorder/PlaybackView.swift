//
//  RecordingsView.swift
//  Recorder
//
//  Created by Prateek Bhardwaj on 03/04/24.
//

import Foundation
import SwiftUI

struct PlaybackView: View {
	@StateObject private var viewModel = PlaybackViewModel()
	@EnvironmentObject var manager: DataManager
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<AudioFiles>
	
	var body: some View {
		List(todoItems.indices, id: \.self) { index in
			HStack {
				Text("Recording \(index + 1)")
				Spacer()
				Button(action: {
					viewModel.playRecording(at: todoItems[index].fileurl)
				}) {
					if viewModel.isPlaying(index: index) {
						Image(systemName: "stop")
					} else {
						Image(systemName: "play")
					}
				}
			}
		}
	}
}

