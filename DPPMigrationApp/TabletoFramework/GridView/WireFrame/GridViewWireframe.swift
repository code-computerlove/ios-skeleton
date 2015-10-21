import Foundation

@objc class GridViewWireframe: NSObject, GridViewWireframeProtocol
{
    let mainWireframe: MainWireframe
    
    required init(mainWireframe: MainWireframe) {
        self.mainWireframe = mainWireframe
    }
    
	func createModule(screenData: ScreenNodeEntity) -> UIViewController? {
		
		if (screenData.screenType == "grid" || screenData.screenType == "scroll") {
			return self.createModule() as? UIViewController
		}
        
        if (screenData.screenType == "page") {
            let contentWireframe = ContentScreenWireframe(mainWireframe: self.mainWireframe)
            let contentViewController = contentWireframe.createModule(ContentScreenViewModel(text: screenData.getPropertyForKey("text"), imagePath:screenData.getPropertyForKey("image"))) as? UIViewController
            return contentViewController
        }
    
		return nil
	}
	
	func createModule() -> GridViewViewProtocol {
		
		let storyboard = UIStoryboard(name: "GridViewStoryboard", bundle: nil)
		let viewController : GridViewViewProtocol = storyboard.instantiateInitialViewController() as! GridViewViewProtocol
		
		let contentBaseUrl = NSURL(fileURLWithPath: DPPConfig.baseContentDirectory())
		let contentUrl = contentBaseUrl.URLByAppendingPathComponent("content.json")
		
		let appContentDataStore: DataStoreReaderProtocol = JsonFileDataStore(path: contentUrl.path!)
		let dataManager: GridViewDataManagerInputProtocol = GridViewDataManager(appContentDataStore: appContentDataStore)
		let interactor: GridViewInteractorInputProtocol = GridViewInteractor(dataManager: dataManager)
		let presenter: protocol<GridViewPresenterProtocol, GridViewInteractorOutputProtocol> = GridViewPresenter(view: viewController, interactor: interactor, wireframe: self)
		
		//Add weak references
		viewController.eventHandler = presenter
		interactor.presenter = presenter
		
		return viewController
	}
	
	func presentSelfWithViewModel(viewModel: CollectionScreenViewModel) {
		
		let gridView = self.createModule()
		gridView.screenData = viewModel
		
		mainWireframe.router.navigateToViewController(gridView as! UIViewController)
    }
    
    func presentModule(screenData: ScreenNodeEntity) {
        
        if (screenData.screenType == "grid" || screenData.screenType == "scroll") {
            
            let wireframe = GridViewWireframe(mainWireframe: self.mainWireframe)
            let viewModel : CollectionScreenViewModel = CollectionScreenMapper.mapEntityToViewModel(screenData)
            wireframe.presentSelfWithViewModel(viewModel)
        }
        
        if (screenData.screenType == "content") {
            
            let wireframe = ContentScreenWireframe(mainWireframe: self.mainWireframe)
            wireframe.presentSelfWithViewModel(ContentScreenViewModel(text: screenData.title!, imagePath:screenData.thumbnailImagePath!))
        }
    }
}