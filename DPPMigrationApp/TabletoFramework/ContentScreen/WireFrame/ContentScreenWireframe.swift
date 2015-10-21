import Foundation

class ContentScreenWireframe: ContentScreenWireframeProtocol
{
    let mainWireframe: MainWireframe
    
    required init(mainWireframe: MainWireframe) {
        self.mainWireframe = mainWireframe
    }
    
    func createModule(viewModel: ContentScreenViewModel) -> ContentScreenViewProtocol {
        
        let storyboard = UIStoryboard(name: "ContentScreenStoryboard", bundle: nil)
        let viewController : ContentScreenViewProtocol = storyboard.instantiateInitialViewController() as! ContentScreenViewController
        
        let contentBaseUrl = NSURL(fileURLWithPath: DPPConfig.baseContentDirectory())
        let contentUrl = contentBaseUrl.URLByAppendingPathComponent("content.json")
        
        let appContentDataStore: DataStoreReaderProtocol = JsonFileDataStore(path: contentUrl.path!)
        let dataManager: ContentScreenDataManagerInputProtocol = ContentScreenDataManager(appContentDataStore: appContentDataStore)
        let interactor: ContentScreenInteractorInputProtocol = ContentScreenInteractor(dataManager: dataManager)
        let presenter: protocol<ContentScreenPresenterProtocol, ContentScreenInteractorOutputProtocol> = ContentScreenPresenter(view: viewController, interactor: interactor, wireframe: self)
        
        //Add weak references
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        
        viewController.viewModel = viewModel
        
        return viewController
    }
   
    func presentSelfWithViewModel(viewModel: ContentScreenViewModel) {
        
        let contentView = createModule(viewModel)
        
        mainWireframe.router.navigateToViewController(contentView as! UIViewController)
    }
}