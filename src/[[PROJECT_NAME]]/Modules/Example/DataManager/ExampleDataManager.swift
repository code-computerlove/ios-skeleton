import Foundation

class ExampleDataManager: ExampleDataManagerProtocol {

	var appContentDataStore: DataStoreReaderProtocol!
	
	// ExampleDataManagerProtocol Functions
	
	required init(appContentDataStore: DataStoreReaderProtocol) {
		self.appContentDataStore = appContentDataStore
	}
	
	
}