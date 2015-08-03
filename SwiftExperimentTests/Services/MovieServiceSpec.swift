import Quick
import Nimble
import SwiftExperiment

class MovieServiceSpec: QuickSpec {
  override func spec() {
    var subject: MovieService!
    let requestProvider = MockRequestProvider()
    let jsonClient = MockJSONClient()
    var closureWasCalled: Bool = false
    var movieParam: [Movie]!
    var errorParam: NSError!

    beforeEach {
      requestProvider.receivedGetMoviesRequest = false
      jsonClient.receivedSendRequest = false
      closureWasCalled = false

      subject = MovieService(requestProvider: requestProvider, jsonClient: jsonClient)
    }

    describe("getMovies()") {
      beforeEach {
        subject.getMovies {
          (movie, error) in
          closureWasCalled = true
          movieParam = movie
          errorParam = error
        }
      }

      it("gets the getMovies request from the request provider") {
        expect(requestProvider.receivedGetMoviesRequest).to(beTrue())
      }

      it("messages the json client to send the request") {
        expect(jsonClient.receivedSendRequest).to(beTrue())
        expect(jsonClient.requestParam).to(beIdenticalTo(requestProvider.fakeGetMoviesRequest))
      }

      describe("when the request returns") {
        context("successfully") {
          var movie: Movie!

          beforeEach {
            movie = Movie(title: "A movie")
            let json = [
              "movies": [
                [
                  "title": "A movie",
                  "posters": [
                    "thumbnail": "example.com/posters/thumbnail",
                    "profile": "example.com/posters/profile",
                    "detailed": "example.com/posters/detailed",
                    "original": "example.com/posters/original"
                  ]
                ]
              ]
            ]
            jsonClient.sendRequestClosure(json: json, error: nil)
          }

          it("calls its closure with the array of movies") {
            expect(closureWasCalled).to(beTruthy())
          }

          it("passes to the closure the array of movies") {
            expect(movieParam).to(equal([movie]))
          }

          it("passes to the closure a nil error") {
            expect(errorParam).to(beNil())
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "MovieServiceError", code: 0, userInfo: nil)
            jsonClient.sendRequestClosure(json: nil, error: error)
          }

          it("calls its closure with the error") {
            expect(closureWasCalled).to(beTruthy())
          }

          it("passes to the closure a nil array of movies") {
            expect(movieParam).to(beNil())
          }

          it("passes to the closure the error") {
            expect(errorParam).to(equal(error))
          }
        }
      }
    }
  }
}
