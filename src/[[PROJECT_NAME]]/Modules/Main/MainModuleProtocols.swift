import Foundation
import UIKit


protocol MainWireframeProtocol: class {
	init(window: UIWindow, config: AppConfig)
	func presentRootScreen()
}

protocol MainViewProtocol: class {
	var eventHandler: MainPresenterProtocol! { get set }
}

protocol MainPresenterProtocol: class {
	init(
		view: MainViewProtocol, 
		interactor: MainInteractorInputProtocol, 
		wireframe: MainWireframeProtocol)
	func prepareView()
}

protocol MainInteractorOutputProtocol: class {
	
}

protocol MainInteractorInputProtocol: class {
	weak var presenter: MainInteractorOutputProtocol? { get set }
	init(dataManager: MainDataManagerProtocol)
}

protocol MainDataManagerProtocol: class {
	init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>)
}