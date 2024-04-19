import CoreData
import Foundation

/// Main data manager to handle the todo items
class DataManager: NSObject, ObservableObject {
	/// Dynamic properties that the UI will react to
	@Published var audioFiles: [AudioFiles] = [AudioFiles]()
	
	/// Add the Core Data container with the model name
	let container: NSPersistentContainer = NSPersistentContainer(name: "AudioFiles")
	
	/// Default init method. Load the Core Data container
	override init() {
		super.init()
		container.loadPersistentStores { _, _ in }
		
		print(container.persistentStoreCoordinator.persistentStores.first?.url)
	}
}
