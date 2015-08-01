import Quick
import Nimble
import SwiftExperiment

class MovieDetailViewPresenterSpec: QuickSpec {
    override func spec() {
      var subject: MovieDetailViewPresenter!
      var movie: Movie!
      var imageService: ImageServiceInterface!

      beforeEach {
        movie = Movie()
        imageService = MockImageService()
        subject = MovieDetailViewPresenter(movie: movie, imageService: imageService)
      }

      describe("presentInView()") {
        var view: MovieDetailView!

        beforeEach {
          let vc = MovieDetailViewController.getInstanceFromStoryboard("Main")
          view = vc.view as! MovieDetailView
          subject.presentInView(view)
        }

        it("sets the title label's text to the movie's title") {
          if let titleLabel = view.titleLabel {
            expect(titleLabel.text).to(equal("A title"))
          } else {
            XCTFail()
          }
        }
      }
    }
}
