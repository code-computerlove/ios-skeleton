import Foundation
import SwiftyJSON
import ObjectMapper


class MainDataManager: MainDataManagerProtocol {
	
	let dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>
	
	// MainDataManagerProtocol Functions
	
	required init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>) {
		self.dataStore = dataStore
	}
}