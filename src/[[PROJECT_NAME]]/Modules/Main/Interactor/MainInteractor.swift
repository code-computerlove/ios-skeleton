import Foundation
import SwiftyJSON


class MainInteractor: MainInteractorInputProtocol {

	weak var presenter: MainInteractorOutputProtocol?
	let dataManager: MainDataManagerProtocol
	
	
	// MainInteractorInputProtocol Functions
	
	required init(dataManager: MainDataManagerProtocol) {
		self.dataManager = dataManager
	}
}