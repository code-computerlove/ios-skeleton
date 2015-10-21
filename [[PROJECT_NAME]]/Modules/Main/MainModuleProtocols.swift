import Foundation
import SwiftyJSON


protocol MainModuleWireframeProtocol: class {
	
	init(window: UIWindow, config: AppConfig)
	func testModuleSetup()
}

@objc protocol MainModuleViewProtocol: class {
	
	var eventHandler: MainPresenter { get set }
}

protocol MainModulePresenterProtocol: class {
	
	init(view: MainModuleViewProtocol, interactor: MainModuleInteractorInputProtocol, wireframe: MainModuleWireframeProtocol)
	var userInterface: MainModuleViewProtocol { get }
	func prepareView()
}

protocol MainModuleInteractorOutputProtocol: class {
	

}

protocol MainModuleInteractorInputProtocol: class {
	
	init(dataManager: MainModuleDataManagerProtocol)
}

protocol MainModuleDataManagerProtocol: class {
	
	init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>)
}