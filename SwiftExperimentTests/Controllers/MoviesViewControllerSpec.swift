import Quick
import Nimble
import SwiftExperiment

class MoviesViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: MoviesViewController!
    var view: MoviesView!
    let movieService = MockMovieService()
    let moviesPresenter = MockMoviesPresenter()

    beforeEach {
      subject = MoviesViewController.getInstanceFromStoryboard("Main") as! MoviesViewController
      subject.configure(movieService: movieService, moviesPresenter: moviesPresenter)
      movieService.resetSentMessages()
      moviesPresenter.resetSentMessages()

      subject.renderView()
      view = subject.moviesView
    }

    describe("when the view loads") {
      it("messages the movie service to get movies") {
        expect(movieService.getMovies.wasReceived).to(beTruthy())
      }

      describe("when the service returns") {
        context("successfully") {
          let movie0 = Movie(title: "Wall-E")
          let movie1 = Movie(title: "Up")

          beforeEach {
            movieService.getMovies.closure(movies: [movie0, movie1], error: nil)
          }

          it("messages the moviesPresenter to present the movies in the tableView") {
            expect(moviesPresenter.present.wasReceived).to(beTruthy())
          }

          it("passes the movies to the movies presenter") {
            expect(moviesPresenter.present.params.movies).to(equal([movie0, movie1]))
          }

          it("passes the table view to the movies presenter") {
            expect(moviesPresenter.present.params.tableView).to(beIdenticalTo(view.tableView))
          }
        }

        context("with error") {
          let error = NSError(domain: "MovieServiceError", code: 0, userInfo: ["NSLocalizedDescription": "Could not get movie list"])
          var alertController: UIAlertController!

          beforeEach {
            movieService.getMovies.closure(movies: nil, error: error)
            alertController = subject.presentedViewController as! UIAlertController
          }

          it("presents an alert controller") {
            expect(subject.presentedViewController).to(beAnInstanceOf(UIAlertController.self))
          }

          it("sets the alert's title") {
            expect(alertController.title).to(equal("Error"))
          }

          it("sets the alert's message") {
            expect(alertController.message).to(equal("Could not get movie list"))
          }
        }
      }
    }

    describe("tapping a cell") {
      var cell: MovieTableViewCell!
      var movieDetailViewController: MovieDetailViewController!

      beforeEach {
        let movie0 = Movie(title: "Wall-E")
        let movie1 = Movie(title: "Up")
        movieService.getMovies.closure(movies: [movie0, movie1], error: nil)

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
        if let viewPresenter = movieDetailViewController.viewPresenter as? MovieDetailViewPresenter {
          expect(viewPresenter.movie.title).to(equal("Wall-E"))
        } else {
          XCTFail()
        }
      }
    }
  }
}
