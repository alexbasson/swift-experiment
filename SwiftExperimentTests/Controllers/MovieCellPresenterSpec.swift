import Quick
import Nimble
import SwiftExperiment

class MovieCellPresenterSpec: QuickSpec {
    override func spec() {
      var subject: MovieCellPresenter!
      var movie: Movie!
      var imageService: MockImageService!

      beforeEach {
        movie = Movie()
        imageService = MockImageService()

        subject = MovieCellPresenter(movie: movie, imageService: imageService)
      }
    }
}
