import UIKit

public class MovieCellPresenter: CellPresenter {
  public let movie: Movie

  public init(movie: Movie) {
    self.movie = movie
  }

  public static func registerInTableView(tableView: UITableView) {
    tableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier())
  }

  public func presentInCell(cell: UITableViewCell) {
    let movieCell = cell as! MovieTableViewCell
    movieCell.titleLabel.text = movie.title
  }

  public func cellIdentifier() -> String {
    return MovieTableViewCell.reuseIdentifier()
  }
}
