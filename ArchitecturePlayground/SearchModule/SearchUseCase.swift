import Foundation

protocol SearchUseCase {
    
    func inputTextAction(_ value: String)
    func searchAction()
    func reset()
    func transitionDetailAction(index: Int)
}

class SearchInteractor: SearchUseCase {
    
    let presenter: SearchPresenter
    let qiitaRepository: QiitaRepository
    let stateManager: StateManager<SearchState>
    
    init(presenter: SearchPresenter, qiitaRepository: QiitaRepository, stateManager: StateManager<SearchState>) {
        self.presenter = presenter
        self.qiitaRepository = qiitaRepository
        self.stateManager = stateManager
    }
    
    func inputTextAction(_ value: String) {
        var newState = stateManager.duplicate()
        newState.searchText = value
        stateManager.set(newState) { state in
            presenter.updateSearchText(state)
        }
    }
    
    func searchAction() {
        var newState = stateManager.duplicate()
        qiitaRepository.fetch(query: newState.searchText) { result in
            switch result {
            case .success(let response):
                newState.result = response.map{
                    .init(title: $0.title, likeCount: $0.likesCount)
                }
                stateManager.set(newState, useHandler: { state in
                    presenter.showResult(state)
                })
            case .failure(let error):
                break
            }
        }

    }
    
    func reset() {
        var newState = stateManager.duplicate()
        newState.searchText = ""
        newState.result = []
        stateManager.set(newState) { state in
            presenter.updateSearchText(state)
            presenter.showResult(state)
        }
    }
    
    func transitionDetailAction(index: Int) {
        // TODO:
    }

}
