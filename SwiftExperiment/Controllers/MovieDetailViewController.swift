import UIKit

public class MovieDetailViewController: UIViewController {
  private(set) public var viewPresenter: ViewPresenter?

  public func configure(movie movie: Movie) -> Void {
    self.viewPresenter = MovieDetailViewPresenter(movie: movie, imageService: ImageService.sharedInstance)
  }

  public func configure(movie movie: Movie, movieDetailViewPresenter: ViewPresenter) {
    self.configure(movie: movie)
    self.viewPresenter = movieDetailViewPresenter
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    if let viewPresenter = viewPresenter {
      viewPresenter.presentInView(self.view)
    }
  }
}
