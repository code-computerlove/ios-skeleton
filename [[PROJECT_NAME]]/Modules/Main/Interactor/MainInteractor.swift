import Foundation
import SwiftyJSON


class MainInteractor: MainModuleInteractorInputProtocol {

	weak var presenter: MainModuleInteractorOutputProtocol?
	let dataManager: MainModuleDataManagerProtocol
	
	
	// MainModuleInteractorInputProtocol Functions
	
	required init(dataManager: MainModuleDataManagerProtocol) {
		self.dataManager = dataManager
	}
}