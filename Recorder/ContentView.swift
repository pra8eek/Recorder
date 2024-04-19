//
//  ContentView.swift
//  Recorder
//
//  Created by Prateek Bhardwaj on 03/04/24.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject private var manager: DataManager = DataManager()
	
    var body: some View {
		TabView {
			RecordView()
				.tabItem {
					Image(systemName: "mic")
					Text("Recording")
				}
				.environmentObject(manager)
				.environment(\.managedObjectContext, manager.container.viewContext)
			
			PlaybackView()
				.tabItem {
					Image(systemName: "list.bullet")
					Text("Recordings")
				}
				.environmentObject(manager)
				.environment(\.managedObjectContext, manager.container.viewContext)
		}
    }
}

#Preview {
    ContentView()
}
