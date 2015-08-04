import UIKit
import SwiftExperiment

class MockMoviesPresenter: MoviesPresenter {
  typealias presentTuple = (wasReceived: Bool, params: (movies: [Movie]!, tableView: UITableView!))

  var present: presentTuple = (wasReceived: false, params: (movies: nil, tableView: nil))
  override func present(movies movies: [Movie], tableView: UITableView?) {
    present = (wasReceived: true, params: (movies: movies, tableView: tableView))
    super.present(movies: movies, tableView: tableView)
  }
}

extension MockMoviesPresenter: Mockable {
  func resetSentMessages() {
    present = (wasReceived: false, params: (movies: nil, tableView: nil))
  }
}
