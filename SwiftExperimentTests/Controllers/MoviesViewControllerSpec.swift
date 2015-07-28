import Quick
import Nimble
import SwiftExperiment

class MoviesViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: MoviesViewController!
    var view: MoviesView!
    let movieService = MockMovieService()
    let imageService = MockImageService()

    beforeEach {
      subject = MoviesViewController.getInstanceFromStoryboard("Main") as! MoviesViewController
      subject.configure(movieService: movieService, imageService: imageService)

      expect(subject.view).notTo(beNil())
      view = subject.moviesView
    }

    describe("when the view loads") {
      it("messages the movie service to get movies") {
        expect(movieService.receivedGetMovies).to(beTruthy())
      }

      describe("when the service returns") {
        context("successfully") {
          var cells = []

          beforeEach {
            let movie0 = Movie(title: "Wall-E", thumbnailURL: NSURL(string: "example.com/0")!)
            let movie1 = Movie(title: "Up", thumbnailURL: NSURL(string: "example.com/1")!)
            movieService.getMoviesClosure(movies: [movie0, movie1], error: nil)

            if let tableView = view.tableView {
              tableView.layoutIfNeeded()
              cells = tableView.visibleCells
            } else {
              XCTFail()
            }
          }

          describe("the table view") {
            it("has two cells") {
              expect(cells.count).to(equal(2))
            }

            it("sets the title of the first cell to 'Wall-E'") {
              let cell: MovieTableViewCell = cells[0] as! MovieTableViewCell
              expect(cell.titleLabel.text).to(equal("Wall-E"))
            }

            it("sets the title of the second cell to 'Up'") {
              let cell: MovieTableViewCell = cells[1] as! MovieTableViewCell
              expect(cell.titleLabel.text).to(equal("Up"))
            }
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "MovieServiceError", code: 0, userInfo: nil)
            movieService.getMoviesClosure(movies: nil, error: error)
          }
        }
      }
    }

    describe("tapping a cell") {
      var cell: MovieTableViewCell!
      var movieDetailViewController: MovieDetailViewController!

      beforeEach {
        let movie0 = Movie(title: "Wall-E", thumbnailURL: NSURL(string: "example.com/0")!)
        let movie1 = Movie(title: "Up", thumbnailURL: NSURL(string: "example.com/1")!)
        movieService.getMoviesClosure(movies: [movie0, movie1], error: nil)

        if let tableView = view.tableView {
          tableView.layoutIfNeeded()
          cell = tableView.visibleCells[0] as! MovieTableViewCell
          movieDetailViewController = MovieDetailViewController.getInstanceFromStoryboard("Main") as! MovieDetailViewController
          let segue = UIStoryboardSegue(identifier: "ShowMovieDetailSegue", source: subject, destination: movieDetailViewController) {}
          subject.prepareForSegue(segue, sender: cell)
        } else {
          XCTFail()
        }
      }

      it("shows a MoviesDetailViewController and configures it with the movie") {
        expect(movieDetailViewController.movie!.title).to(equal("Wall-E"))
      }
    }
  }
}
