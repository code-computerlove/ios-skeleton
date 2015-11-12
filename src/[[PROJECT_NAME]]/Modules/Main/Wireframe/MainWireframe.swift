import Foundation
import UIKit

class MainWireframe: NSObject, MainWireframeProtocol {
	
	let config: AppConfig
	var router: Router!

	required init(window: UIWindow, config: AppConfig) {

		self.config = config
		super.init()
		
		let viewController = createModule()
		_ = viewController.view
		
		var navigationController: UINavigationController?
		
		if !viewController.childViewControllers.isEmpty {
			if viewController.childViewControllers[0] is UINavigationController {
				navigationController = viewController.childViewControllers[0] as? UINavigationController
			}
		}
		
		if (navigationController == nil) {
			navigationController = UINavigationController()
			viewController.addChildViewController(navigationController!)
			viewController.view.addSubview(navigationController!.view)
		}

		window.rootViewController = viewController;
		self.router = Router(rootViewController: viewController, navigationController: navigationController!)
	}
	
	func presentRootScreen(viewModel: ExampleViewModel) {
		
		//Create and present your module here. e.g.
		//
		//let exampleWireframe = ExampleWireframe(mainWireframe: self)
		//exampleWireframe.presentSelfWithViewModel(viewModel)
	}
	
	private func createModule() -> UIViewController {
		
		let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
		let viewController = storyboard.instantiateInitialViewController()!
		let userInterface = viewController as! MainViewProtocol
		let dataStore = JsonFileDataStore(path: config.appContentFilePath);
		let dataManager: MainDataManagerProtocol = MainDataManager(dataStore: dataStore)
		let interactor = MainInteractor(dataManager: dataManager)
		let presenter = MainPresenter(
			view: userInterface,
			interactor: interactor,
			wireframe: self)
		
		userInterface.eventHandler = presenter
		interactor.presenter = presenter

		return viewController
	}
}