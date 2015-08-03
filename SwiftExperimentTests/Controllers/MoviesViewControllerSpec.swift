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

      expect(subject.view).notTo(beNil())
      view = subject.moviesView
    }

    describe("when the view loads") {
      it("messages the movie service to get movies") {
        expect(movieService.receivedGetMovies).to(beTruthy())
      }

      describe("when the service returns") {
        context("successfully") {
          let movie0 = Movie(title: "Wall-E")
          let movie1 = Movie(title: "Up")

          beforeEach {
            movieService.getMoviesClosure(movies: [movie0, movie1], error: nil)
          }

          it("messages the moviesPresenter to present the movies in the tableView") {
            expect(moviesPresenter.receivedPresentMoviesInTableView).to(beTruthy())
          }

          it("passes the movies to the movies presenter") {
            expect(moviesPresenter.presentMoviesInTableViewParams.movies).to(equal([movie0, movie1]))
          }

          it("passes the table view to the movies presenter") {
            expect(moviesPresenter.presentMoviesInTableViewParams.tableView).to(beIdenticalTo(view.tableView))
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
        let movie0 = Movie(title: "Wall-E")
        let movie1 = Movie(title: "Up")
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
        if let viewPresenter = movieDetailViewController.viewPresenter as? MovieDetailViewPresenter {
          expect(viewPresenter.movie.title).to(equal("Wall-E"))
        } else {
          XCTFail()
        }
      }
    }
  }
}
