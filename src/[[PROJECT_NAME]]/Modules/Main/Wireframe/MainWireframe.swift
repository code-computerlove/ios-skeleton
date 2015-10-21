import Foundation

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

		let navigationController = UINavigationController()
		
		if viewController.childViewControllers[0] {
			navigationController = viewController.childViewControllers[0]
		}

		window.rootViewController = viewController;
		self.router = Router(rootViewController: viewController, navigationController: navigationController)
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
		
		window.backgroundColor = UIColor.whiteColor()
	}
	
	func showContentUpdateView(viewModel: ContentUpdateViewModel, fromView: UIViewController) {
		
		let updateViewController = DPPContentUpdaterViewController(title: viewModel.title, versionNumber: viewModel.version, releaseNotes: viewModel.notes, mediaSize: viewModel.mediaSize, isPreview: viewModel.isPreview)
		
		updateViewController.delegate = fromView as? protocol<DPPContentUpdaterDelegate>
		
		fromView.modalPresentationStyle = UIModalPresentationStyle.PageSheet
		fromView.presentViewController(updateViewController, animated: true, completion: nil)
	}
	
	func presentRootScreen(viewModel: CollectionScreenViewModel) {
		
		let gridWireframe = GridViewWireframe(mainWireframe: self)
		gridWireframe.presentSelfWithViewModel(viewModel)
	}
}