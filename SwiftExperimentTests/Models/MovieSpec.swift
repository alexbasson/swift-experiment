import Quick
import Nimble
import SwiftExperiment

class MovieSpec: QuickSpec {
  override func spec() {
    var movie1: Movie!
    var movie2: Movie!
    var movie3: Movie!

    beforeEach {
      movie1 = Movie(title: "equal", thumbnailURL: NSURL(string: "example.com/0")!)
      movie2 = Movie(title: "equal", thumbnailURL: NSURL(string: "example.com/1")!)
      movie3 = Movie(title: "unequal", thumbnailURL: NSURL(string: "example.com/2")!)
    }

    describe("==") {
      it("equates movies with the same title") {
        expect(movie1).to(equal(movie2))
        expect(movie1).toNot(equal(movie3))
        expect(movie2).toNot(equal(movie3))
      }
    }

    describe("serializable") {
      var movie: Movie!
      var dictionary: Dictionary<String, AnyObject>!

      beforeEach {
        movie = Movie(title: "A title", thumbnailURL: NSURL(string: "example.com")!)
        dictionary = ["title": "A title", "posters": ["thumbnail": "example.com"]]
      }

//      describe("serialize") {
//        it("serializes the movie into a dictionary") {
//          expect(movie.serialize()).to(equal(dictionary))
//        }
//      }

      describe("init(dict:))") {
        it("deserializes the dictionary into a Movie") {
          expect(Movie(dict: dictionary)).to(equal(movie))
        }
      }
    }
  }
}
