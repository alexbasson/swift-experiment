import UIKit

public class MoviesPresenter {
  let cellPresenterDataSource: CellPresenterDataSource

  public init(cellPresenterDataSource: CellPresenterDataSource) {
    self.cellPresenterDataSource = cellPresenterDataSource
  }

  public convenience init() {
    self.init(cellPresenterDataSource: CellPresenterDataSource())
  }

  public func presentMoviesInTableView(movies movies: [Movie], tableView: UITableView?) -> Void {
    var cellPresenters: [CellPresenter] = []

    for movie in movies {
      cellPresenters.append(MovieCellPresenter(movie: movie, imageService: ImageService.sharedInstance))
    }

    cellPresenterDataSource.displayCellPresentersInTableView(cellPresenters: cellPresenters, tableView: tableView)
  }
}
