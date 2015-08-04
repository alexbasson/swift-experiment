import Quick
import Nimble
import SwiftExperiment

class MovieDetailViewPresenterSpec: QuickSpec {
    override func spec() {
      var subject: MovieDetailViewPresenter!
      let movie = Movie()
      let imageService = MockImageService()

      beforeEach {
        imageService.resetSentMessages()
        subject = MovieDetailViewPresenter(movie: movie, imageService: imageService)
      }

      describe("presentInView()") {
        var view: MovieDetailView!

        beforeEach {
          let vc = MovieDetailViewController.getInstanceFromStoryboard("Main")
          view = vc.view as! MovieDetailView
          subject.present(view)
        }

        it("sets the title label's text to the movie's title") {
          if let titleLabel = view.titleLabel {
            expect(titleLabel.text).to(equal("A title"))
          } else {
            XCTFail()
          }
        }

        it("messages the image service to fetch the poster image") {
          expect(imageService.fetchImage.wasReceived).to(beTrue())
        }
      }
    }
}
