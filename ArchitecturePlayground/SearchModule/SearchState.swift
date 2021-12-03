import Foundation

protocol State {
    static func initState() -> Self
}

struct SearchState: State {
    
    struct QiitaItem {
        var title: String
        var likeCount: Int
    }
    
    var searchText: String
    var result: [QiitaItem]
    
    static func initState() -> SearchState {
        return .init(searchText: "", result: [])
    }
}
