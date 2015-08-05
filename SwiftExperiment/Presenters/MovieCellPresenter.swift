import UIKit

func performOnMainQueue(closure: () -> Void) {
  dispatch_async(dispatch_get_main_queue()) {
    closure()
  }
}

public class MovieCellPresenter {
  public let movie: Movie
  public let imageService: ImageServiceInterface

  public init(movie: Movie, imageService: ImageServiceInterface) {
    self.movie = movie
    self.imageService = imageService
  }
}

extension MovieCellPresenter: CellPresenter {
  public static func register(tableView tableView: UITableView) {
    tableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier())
  }

  public func present(cell: UITableViewCell) {
    let movieCell = cell as! MovieTableViewCell
    movieCell.titleLabel.text = movie.title
    imageService.fetchImage(url: movie.posters.thumbnailURL) {
      (image) -> Void in
      performOnMainQueue() {
        movieCell.thumbnailImageView.image = image
      }
    }
  }

  public func cellIdentifier() -> String {
    return MovieTableViewCell.reuseIdentifier()
  }
}
