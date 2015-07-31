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

//      describe("presentInCell") {
//        var movieCell: MovieTableViewCell!
//
//        beforeEach {
//          movieCell = MovieTableViewCell()
//          subject.presentInCell(movieCell)
//        }
//
//        it("sets the title label on the cell") {
//          expect(movieCell.titleLabel.text).to(equal("A title"))
//        }
//      }

      describe("cellIdentifier()") {
        it("returns the cell's reuse identifier") {
          expect(subject.cellIdentifier()).to(equal("MovieTableViewCell"))
        }
      }
    }
}
