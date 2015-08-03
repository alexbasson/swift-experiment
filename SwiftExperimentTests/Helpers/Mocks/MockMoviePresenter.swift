import UIKit
import SwiftExperiment

class MockMoviesPresenter: MoviesPresenter {
  var receivedPresent = false
  var presentParams: (movies: [Movie], tableView: UITableView?)!

  override func present(movies movies: [Movie], tableView: UITableView?) {
    receivedPresent = true
    presentParams = (movies: movies, tableView: tableView)
    super.present(movies: movies, tableView: tableView)
  }
}

extension MockMoviesPresenter: Mockable {
  func resetSentMessages() {
    receivedPresent = false
  }
}
