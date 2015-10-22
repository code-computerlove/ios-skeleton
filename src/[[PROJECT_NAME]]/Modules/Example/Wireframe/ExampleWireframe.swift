import Foundation
import UIKit


class ExampleWireframe : ExampleWireframeProtocol {

	private let mainWireframe: MainWireframe
	
	required init(mainWireframe: MainWireframe) {
		self.mainWireframe = mainWireframe
	}
	
	func presentSelfWithViewModel(viewModel: ExampleViewModel) {
		
		let moduleView = self.createModule()
		moduleView.viewModel = viewModel
		mainWireframe.router.navigateToViewController(moduleView as! UIViewController)
	}
	
	private func createModule() -> ExampleViewProtocol {
		
		let storyboard = UIStoryboard(name: "Example", bundle: nil)
		let viewController : ExampleViewProtocol = storyboard.instantiateInitialViewController() as! ExampleViewProtocol
		let appContentDataStore: DataStoreReaderProtocol = JsonFileDataStore(path: mainWireframe.config.appContentFilePath)
		let dataManager: ExampleDataManagerProtocol = ExampleDataManager(appContentDataStore: appContentDataStore)
		let interactor: ExampleInteractorInputProtocol = ExampleInteractor(dataManager: dataManager)
		let presenter: protocol<ExamplePresenterProtocol, ExampleInteractorOutputProtocol> = ExamplePresenter(view: viewController, interactor: interactor, wireframe: self)
		
		viewController.eventHandler = presenter
		interactor.presenter = presenter
		
		return viewController
	}
}