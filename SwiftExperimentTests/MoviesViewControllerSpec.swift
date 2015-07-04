import Quick
import Nimble
import SwiftExperiment

class MoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: MoviesViewController!
        var view: MoviesView!

        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            subject = storyboard.instantiateViewControllerWithIdentifier("MoviesViewController") as! MoviesViewController

            let movies = ["Wall-E", "Up", "Ratatouille"]
            subject.movies = movies

            expect(subject.view).notTo(beNil())
            view = subject.moviesView
            if let tableView = view.tableView {
                tableView.layoutIfNeeded()
            }
        }

        describe("when the view loads") {
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
