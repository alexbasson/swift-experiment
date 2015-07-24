import UIKit

public class MovieDetailViewController: UIViewController {
  public var movieDetailView: MovieDetailView! { return self.view as! MovieDetailView }

  private(set) public var movie: Movie?

  public func configureWithMovie(movie: Movie) -> Void {
    self.movie = movie
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    if let movie = movie {
      movieDetailView.titleLabel?.text = movie.title
    }
  }

}
