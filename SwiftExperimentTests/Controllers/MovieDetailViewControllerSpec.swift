import Quick
import Nimble
import SwiftExperiment

class MovieDetailViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: MovieDetailViewController!
    var view: MovieDetailView!
    let movie = Movie(title: "A Title")

    beforeEach {
      subject = MovieDetailViewController.getInstanceFromStoryboard("Main") as! MovieDetailViewController
      subject.configureWithMovie(movie)

      expect(subject.view).notTo(beNil())
      view = subject.movieDetailView
    }

    describe("when the view loads") {
      it("sets the title label text") {
        expect(view.titleLabel!.text).to(equal("A Title"))
      }
    }
  }
}
