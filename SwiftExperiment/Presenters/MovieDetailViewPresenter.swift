import UIKit

public class MovieDetailViewPresenter: ViewPresenter {
  var view: MovieDetailView?
  let imageService: ImageServiceInterface

  public let movie: Movie

  public init(movie: Movie, imageService: ImageServiceInterface) {
    self.movie = movie
    self.imageService = imageService
  }

  public func presentInView(view: UIView) {
    let view = view as! MovieDetailView
    if let titleLabel = view.titleLabel {
      titleLabel.text = movie.title
    }

    imageService.fetchImage(url: movie.posters.thumbnailURL) {
      (image) in
      if let posterImageView = view.posterImageView {
        posterImageView.image = image
      }
    }
  }
}
