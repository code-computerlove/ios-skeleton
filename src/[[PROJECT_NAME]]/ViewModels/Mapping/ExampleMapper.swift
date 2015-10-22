import Foundation


class ExampleMapper {
    
    static func mapEntityToViewModel(entity: ExampleEntity) -> ExampleViewModel {
        
        let viewModel = ExampleViewModel(title: entity.title)
        return viewModel
    }
}