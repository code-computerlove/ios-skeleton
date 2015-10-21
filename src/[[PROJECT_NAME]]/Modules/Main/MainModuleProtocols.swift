import Foundation
import UIKit


protocol MainModuleWireframeProtocol: class {
	
	init(window: UIWindow, config: AppConfig)
	func presentRootScreen(viewModel: ExampleViewModel)
}

protocol MainModuleViewProtocol: class {
	
	var eventHandler: MainModulePresenterProtocol! { get set }
	func testModuleSetup()
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