import Foundation

protocol SearchPresenter {
    
    func updateSearchText(_ state: SearchState)
    func showResult(_ state: SearchState)
}

protocol SearchOutput {
    func reload(viewData: SearchResultViewData)
    func setSearchBar(value: String)
}

class SearchPresenterImpl: SearchPresenter {
    
    let output: SearchOutput
    
    init(output: SearchOutput) {
        self.output = output
    }
    
    func updateSearchText(_ state: SearchState) {
        output.setSearchBar(value: state.searchText)
    }
    
    func showResult(_ state: SearchState) {
        let resultItems = state.result.map { qiitaItem in
            SearchResultViewData.ResultItem(title: qiitaItem.title, likeCount: qiitaItem.likeCount)
        }
        output.reload(viewData: .init(results: resultItems))
    }
}
