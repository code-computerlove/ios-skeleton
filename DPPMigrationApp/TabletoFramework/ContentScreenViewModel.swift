import Foundation

struct ContentScreenViewModel {
    
    let text: String?
    let imagePath: String?
    
    init(text: String?, imagePath: String?) {
        self.text = text
        self.imagePath = imagePath
    }
}