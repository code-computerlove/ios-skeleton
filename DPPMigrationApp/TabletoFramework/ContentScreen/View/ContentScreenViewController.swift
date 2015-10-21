import Foundation
import UIKit

class ContentScreenViewController: UIViewController, ContentScreenViewProtocol, UIWebViewDelegate
{
    var eventHandler: ContentScreenPresenterProtocol?
    var viewModel: ContentScreenViewModel?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        webView.delegate = self
        
        if let text = viewModel!.text {
            self.webView.loadHTMLString(text, baseURL: nil)
        } else {
            self.webView.removeFromSuperview()
        }
        
        if let imageId = viewModel!.imagePath, fullImagePath = eventHandler?.getFullPathForMediaItemById(imageId) {
            self.imageView.image = UIImage(contentsOfFile: fullImagePath)
        } else {
            self.imageView.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {        
        if (webView.scrollView.contentSize.height <= webView.frame.size.height) {
            webView.scrollView.bounces = false
        } else {
            webView.scrollView.bounces = true
        }
    }
}