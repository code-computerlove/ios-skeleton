import Foundation
import UIKit


protocol MainWireframeProtocol: class {
	
	init(window: UIWindow, config: AppConfig)
	func presentRootScreen(viewModel: ExampleViewModel)
}

protocol MainViewProtocol: class {
	
	var eventHandler: MainPresenterProtocol! { get set }
}

protocol MainPresenterProtocol: class {
	
	init(view: MainViewProtocol, interactor: MainInteractorInputProtocol, wireframe: MainWireframeProtocol)
	var userInterface: MainViewProtocol { get }
	func prepareView()
}

protocol MainInteractorOutputProtocol: class {
	

}

protocol MainInteractorInputProtocol: class {
	
	init(dataManager: MainDataManagerProtocol)
}

protocol MainDataManagerProtocol: class {
	
	init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>)
}