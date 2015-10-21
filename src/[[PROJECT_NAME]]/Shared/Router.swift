import Foundation


@objc class Router: NSObject {

	let navigationController: UINavigationController
	var topViewController: UIViewController
	
	init(rootViewController: UIViewController, navigationController: UINavigationController) {
		
		self.topViewController = rootViewController
		self.navigationController = navigationController
		
		super.init()
	}
	
	func isViewControllerPresented(viewController: UIViewController) -> Bool {
		return (self.navigationController.topViewController?.isKindOfClass(viewController.classForCoder))!
	}
	
	func navigateToViewController(viewController: UIViewController) {
		
		if self.navigationController.viewControllers.isEmpty {
			self.navigationController.viewControllers = [viewController]
			return
		}
		
		self.topViewController = viewController;
		self.navigationController.pushViewController(viewController, animated: true)
	}
}