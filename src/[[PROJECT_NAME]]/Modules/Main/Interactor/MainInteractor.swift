import Foundation
import SwiftyJSON


class MainInteractor: MainInteractorInputProtocol {

	weak var presenter: MainInteractorOutputProtocol?
	private let dataManager: MainDataManagerProtocol
	
	
	// MainInteractorInputProtocol Functions
	
	required init(dataManager: MainDataManagerProtocol) {
		self.dataManager = dataManager
	}
}