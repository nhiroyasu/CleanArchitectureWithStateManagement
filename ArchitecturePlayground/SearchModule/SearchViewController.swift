import UIKit

struct SearchResultViewData {
    
    struct ResultItem {
        let title: String
        let likeCount: Int
    }
    
    let results: [ResultItem]
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = createLayout()
            collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "UICollectionViewListCell")
        }
    }
    let searchBarController = UISearchController(searchResultsController: nil)
    var actionController: SearchActionController?
    
    private var viewData: SearchResultViewData?
    
    init() {
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
    }

    private func setSearchBar() {
        self.navigationItem.titleView = searchBarController.searchBar
        searchBarController.searchBar.searchBarStyle = .default
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { section, layoutEnv in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnv)
            return section
        }
        return layout
    }

}

extension SearchViewController: SearchOutput {
    
    func setSearchBar(value: String) {
        searchBarController.searchBar.text = value
    }
    
    func reload(viewData: SearchResultViewData) {
        self.viewData = viewData
        collectionView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        actionController?.didTapCancel()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        actionController?.input(searchText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        actionController?.didTapSearchButton()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewListCell", for: indexPath) as! UICollectionViewListCell
        var config = UIListContentConfiguration.valueCell()
        if let item = viewData?.results[indexPath.item] {
            config.text = item.title
            config.secondaryText = String(item.likeCount)
        }
        cell.contentConfiguration = config
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionController?.didTapResultCell(at: indexPath.item)
    }
}
