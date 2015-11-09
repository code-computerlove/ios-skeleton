import Foundation
import UIKit


protocol ExampleWireframeProtocol: class {
	init(mainWireframe: MainWireframe)
	func presentSelfWithViewModel(viewModel: ExampleViewModel)
}

protocol ExampleViewProtocol: class {
	var eventHandler: ExamplePresenterProtocol! { get set }
	func setTitle(title: String?)
}

protocol ExamplePresenterProtocol: class {
	init(view: ExampleViewProtocol, interactor: ExampleInteractorInputProtocol, wireframe: ExampleWireframeProtocol)
	var viewModel: ExampleViewModel? { get set }
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