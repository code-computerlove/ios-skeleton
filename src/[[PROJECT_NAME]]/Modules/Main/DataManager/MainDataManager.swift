import Foundation
import SwiftyJSON
import ObjectMapper


class MainDataManager: MainModuleDataManagerProtocol {
	
	let dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>
	
	// MainModuleDataManagerProtocol Functions
	
	required init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>) {
		self.dataStore = dataStore
	}
}