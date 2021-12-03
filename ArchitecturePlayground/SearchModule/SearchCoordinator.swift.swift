import Foundation
import UIKit

class SearchCoordinator {
    
    init() {
        
    }
    
    func start() -> UIViewController {
        let vc = SearchViewController()
        let presenter = SearchPresenterImpl(output: vc)
        let qiitaRepository = QiitaRepositoryImpl()
        let useCase = SearchInteractor(
            presenter: presenter,
            qiitaRepository: qiitaRepository,
            stateManager: StateManager<SearchState>()
        )
        let action = SearchActionControllerImpl(useCase: useCase)
        vc.actionController = action
        return vc
    }
}
