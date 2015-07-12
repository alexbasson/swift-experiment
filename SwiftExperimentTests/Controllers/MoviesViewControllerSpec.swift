import Quick
import Nimble
import SwiftExperiment

public class MockMovieService: MovieService {
    public var receivedGetMovies = false

    override public func getMovies(closure: ([Movie]) -> ()) {
        receivedGetMovies = true
        let movie0 = Movie(title: "Wall-E")
        let movie1 = Movie(title: "Up")
        let movie2 = Movie(title: "Ratatouille")
        closure([movie0, movie1, movie2])
    }
}

class MoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: MoviesViewController!
        var view: MoviesView!
        let movieService = MockMovieService()

        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            subject = storyboard.instantiateViewControllerWithIdentifier("MoviesViewController") as! MoviesViewController
            subject.configureWithMovieService(movieService)
            
            expect(subject.view).notTo(beNil())
            view = subject.moviesView
            if let tableView = view.tableView {
                tableView.layoutIfNeeded()
            }
        }

        describe("when the view loads") {
            it("messages the movie service to get movies") {
                expect(movieService.receivedGetMovies).to(beTruthy())
            }
        }

        describe("the table view") {
            var cells = []

            beforeEach {
                if let tableView = view.tableView {
                    cells = tableView.visibleCells
                }
            }

            it("has three cells") {
                expect(cells.count).to(equal(3))
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
}
