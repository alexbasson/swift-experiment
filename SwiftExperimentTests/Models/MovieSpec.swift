import Quick
import Nimble
import SwiftExperiment

class MovieSpec: QuickSpec {
  override func spec() {

    describe("==") {
      var movie1: Movie!
      var movie2: Movie!
      var movie3: Movie!

      beforeEach {
        movie1 = Movie(title: "equal")
        movie2 = Movie(title: "equal")
        movie3 = Movie(title: "unequal")
      }
 
      it("equates movies with the same title") {
        expect(movie1).to(equal(movie2))
        expect(movie1).toNot(equal(movie3))
        expect(movie2).toNot(equal(movie3))
      }
    }

    describe("serializable") {
      var subject: Movie!
      var dictionary: Dictionary<String, AnyObject>!

      describe("serialize") {
        beforeEach {
          subject = Movie()
        }

        it("serializes the movie") {
          let dict = subject.serialize()
          expect(dict["title"] as? String).to(equal("A title"))
          expect(dict["posters"] as? Dictionary<String, String>)
            .to(equal([
              "thumbnail": "example.com/posters/thumbnail",
              "profile": "example.com/posters/profile",
              "detailed": "example.com/posters/detailed",
              "original": "example.com/posters/original"
            ])
          )
        }
      }

      describe("init(dict:))") {
        beforeEach {
          subject = Movie()
          dictionary = [
            "title": "A title",
            "posters": [
              "thumbnail": "example.com/posters/thumbnail",
              "profile": "example.com/posters/profile",
              "detailed": "example.com/posters/detailed",
              "original": "example.com/posters/original"
            ]
          ]
        }

        it("deserializes the dictionary into a Movie") {
          expect(Movie(dict: dictionary)).to(equal(subject))
        }
      }
    }
  }
}
