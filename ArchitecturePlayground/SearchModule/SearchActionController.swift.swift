import Foundation

protocol SearchActionController {
    
    func input(searchText: String)
    func didTapSearchButton()
    func didTapCancel()
    func didTapResultCell(at index: Int)
}

class SearchActionControllerImpl: SearchActionController {
    
    let useCase: SearchUseCase
    
    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }
    
    func input(searchText: String) {
        useCase.inputTextAction(searchText)
    }
    
    func didTapSearchButton() {
        useCase.searchAction()
    }
    
    func didTapCancel() {
        useCase.reset()
    }
    
    func didTapResultCell(at index: Int) {
        useCase.transitionDetailAction(index: index)
    }
}
