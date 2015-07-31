import UIKit
import SwiftExperiment

public class MockMoviesPresenter: MoviesPresenter {
  public var receivedPresentMoviesInTableView = false
  public var moviesParam: [Movie]!
  public var tableViewParam: UITableView!

  override public func presentMoviesInTableView(movies movies: [Movie], tableView: UITableView?) {
    receivedPresentMoviesInTableView = true
    moviesParam = movies
    tableViewParam = tableView
    super.presentMoviesInTableView(movies: movies, tableView: tableView)
  }
}
