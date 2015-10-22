import Foundation
import UIKit


protocol ExampleWireframeProtocol: class {
	init(mainWireframe: MainWireframe)
	func presentSelfWithViewModel(viewModel: ExampleViewModel)
}

protocol ExampleViewProtocol: class {
	var eventHandler: ExamplePresenterProtocol! { get set }
	var viewModel: ExampleViewModel? { get set }
}

protocol ExamplePresenterProtocol: class {
	init(view: ExampleViewProtocol, interactor: ExampleInteractorInputProtocol, wireframe: ExampleWireframeProtocol)
	func prepareView()
}

protocol ExampleInteractorOutputProtocol: class {
	
}

protocol ExampleInteractorInputProtocol: class {
	weak var presenter: ExampleInteractorOutputProtocol? {get set }
	init(dataManager: ExampleDataManagerProtocol)
}

protocol ExampleDataManagerProtocol: class {
	init(appContentDataStore: DataStoreReaderProtocol)
}