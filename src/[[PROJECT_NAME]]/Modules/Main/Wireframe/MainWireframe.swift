import Foundation
import UIKit

@objc class MainWireframe: NSObject, MainModuleWireframeProtocol {
	
	let config: AppConfig
	var router: Router!
	
	required init(window: UIWindow, config: AppConfig) {

		self.config = config
		
		super.init()
		
		let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
		
		let viewController = storyboard.instantiateInitialViewController()!
		let userInterface = viewController as! MainModuleViewProtocol
		
		let dataStore = JsonFileDataStore(path: config.appContentFilePath);
		let dataManager = MainDataManager(dataStore: dataStore)
		let interactor = MainInteractor(dataManager: dataManager)
		let presenter = MainPresenter(
			view: userInterface,
			interactor: interactor,
			wireframe: self)
		
		userInterface.eventHandler = presenter
		interactor.presenter = presenter

		var navigationController = UINavigationController()
		
		if !viewController.childViewControllers.isEmpty {
			if viewController.childViewControllers[0] is UINavigationController {
				navigationController = viewController.childViewControllers[0] as! UINavigationController
			}
		}

		window.rootViewController = viewController;
		self.router = Router(rootViewController: viewController, navigationController: navigationController)
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
		
		window.backgroundColor = UIColor.whiteColor()
	}
	
	func presentRootScreen(viewModel: ExampleViewModel) {
		
		let exampleWireframe = ExampleWireframe(mainWireframe: self)
		exampleWireframe.presentSelfWithViewModel(viewModel)
	}
}