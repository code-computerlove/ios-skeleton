import Foundation

class ExampleDataManager: ExampleDataManagerProtocol {

	private let appContentDataStore: DataStoreReaderProtocol
	
	
	// ExampleDataManagerProtocol Functions
	
	required init(appContentDataStore: DataStoreReaderProtocol) {
		self.appContentDataStore = appContentDataStore
	}
}