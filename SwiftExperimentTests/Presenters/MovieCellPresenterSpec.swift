import Quick
import Nimble
import SwiftExperiment

class MockUITableView: UITableView {
  var identifier: String!

  override func registerClass(cellClass: AnyClass?,forCellReuseIdentifier identifier: String) {
    self.identifier = identifier
  }
}

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

      describe("registerInTableView()") {
        var tableView: MockUITableView!

        beforeEach {
          tableView = MockUITableView()
          MovieCellPresenter.registerInTableView(tableView)
        }

        it("registers the movie cell in the table view") {
          expect(tableView.identifier).to(equal("MovieTableViewCell"))
        }
      }

      describe("presentInCell") {
        var movieCell: MovieTableViewCell!

        beforeEach {
          let vc = MoviesViewController.getInstanceFromStoryboard("Main") as! MoviesViewController
          let tableView = vc.moviesView.tableView
          if let tableView = tableView {
            movieCell = tableView.dequeueReusableCellWithIdentifier(MovieTableViewCell.reuseIdentifier()) as! MovieTableViewCell
            subject.presentInCell(movieCell)
          } else {
            XCTFail()
          }
        }

        it("sets the title label on the cell") {
          expect(movieCell.titleLabel.text).to(equal("A title"))
        }
      }

      describe("cellIdentifier()") {
        it("returns the cell's reuse identifier") {
          expect(subject.cellIdentifier()).to(equal("MovieTableViewCell"))
        }
      }
    }
}
