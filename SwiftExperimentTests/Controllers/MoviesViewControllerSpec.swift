import Quick
import Nimble
import SwiftExperiment

public class MockMovieService: MovieServiceInterface {
  public var receivedGetMovies = false
  public var getMoviesClosure: MovieServiceClosure!

  public func getMovies(closure: MovieServiceClosure) {
    receivedGetMovies = true
    getMoviesClosure = closure
  }
}

public class MockMoviesPresenter: MoviesPresenter {
  public var receivedPresentMoviesInTableView = false
  public var moviesParam: [Movie]!
  public var tableViewParam: UITableView!

  override public func presentMoviesInTableView(movies movies: [Movie], tableView: UITableView?) {
    receivedPresentMoviesInTableView = true
    moviesParam = movies
    tableViewParam = tableView
    super.presentMoviesInTableView(movies: movies, tableView: tableView)
  }
}

class MoviesViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: MoviesViewController!
    var view: MoviesView!
    let movieService = MockMovieService()
    let imageService = MockImageService()
    let moviesPresenter = MockMoviesPresenter()

    beforeEach {
      subject = MoviesViewController.getInstanceFromStoryboard("Main") as! MoviesViewController
      subject.configure(movieService: movieService, imageService: imageService, moviesPresenter: moviesPresenter)

      expect(subject.view).notTo(beNil())
      view = subject.moviesView
    }

    describe("when the view loads") {
      it("messages the movie service to get movies") {
        expect(movieService.receivedGetMovies).to(beTruthy())
      }

      describe("when the service returns") {
        context("successfully") {
          var movie0 = Movie(title: "")
          var movie1 = Movie(title: "")

          beforeEach {
            movie0 = Movie(title: "Wall-E")
            movie1 = Movie(title: "Up")
            movieService.getMoviesClosure(movies: [movie0, movie1], error: nil)

          }

          it("messages the moviesPresenter to present the movies in the tableView") {
            expect(moviesPresenter.receivedPresentMoviesInTableView).to(beTruthy())
          }

          it("passes the movies to the movies presenter") {
            expect(moviesPresenter.moviesParam).to(equal([movie0, movie1]))
          }

          it("passes the table view to the movies presenter") {
            expect(moviesPresenter.tableViewParam).to(beIdenticalTo(view.tableView))
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
        expect(movieDetailViewController.movie!.title).to(equal("Wall-E"))
      }
    }
  }
}
