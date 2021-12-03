import Foundation
import UIKit

class MainNavigationViewController: UINavigationController {
    
    var searchCoordinator: SearchCoordinator?

    required init?(coder aDecoder: NSCoder) {
        searchCoordinator = .init()
        super.init(rootViewController: searchCoordinator!.start())
    }
}
