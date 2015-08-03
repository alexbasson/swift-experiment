import UIKit
import SwiftExperiment

class MockMoviesPresenter: MoviesPresenter {
  var receivedPresentMoviesInTableView = false
  var presentMoviesInTableViewParams: (movies: [Movie], tableView: UITableView?)!

  override func presentMoviesInTableView(movies movies: [Movie], tableView: UITableView?) {
    receivedPresentMoviesInTableView = true
    presentMoviesInTableViewParams = (movies: movies, tableView: tableView)
    super.presentMoviesInTableView(movies: movies, tableView: tableView)
  }
}

extension MockMoviesPresenter: Mockable {
  func resetSentMessages() {
    receivedPresentMoviesInTableView = false
  }
}
