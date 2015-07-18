import Quick
import Nimble
import SwiftExperiment

class MovieSpec: QuickSpec {
    override func spec() {
      var movie1: Movie!
      var movie2: Movie!
      var movie3: Movie!

      beforeEach {
        movie1 = Movie(title: "equal")
        movie2 = Movie(title: "equal")
        movie3 = Movie(title: "unequal")
      }

      describe("==") {
        it("equates movies with the same title") {
          expect(movie1).to(equal(movie2))
          expect(movie1).toNot(equal(movie3))
          expect(movie2).toNot(equal(movie3))
        }
      }
    }
}
