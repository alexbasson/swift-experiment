import Quick
import Nimble
import SwiftExperiment

class MovieServiceSpec: QuickSpec {
  override func spec() {
    var subject: MovieService!
    var requestProvider: MockRequestProvider!
    var jsonClient: MockJSONClient!
    var closureWasCalled: Bool = false
    var movieParam: [Movie]!
    var errorParam: NSError!

    beforeEach {
      requestProvider = MockRequestProvider()
      jsonClient = MockJSONClient()

      subject = MovieService(requestProvider: requestProvider, jsonClient: jsonClient)

      expect(requestProvider.receivedGetMoviesRequest).to(beFalsy())
      expect(jsonClient.receivedSendRequest).to(beFalsy())

      closureWasCalled = false
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
        expect(requestProvider.receivedGetMoviesRequest).to(beTruthy())
      }

      it("messages the json client to send the request") {
        expect(jsonClient.receivedSendRequest).to(beTruthy())
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
            expect(movieParam).to(equal([movie]))
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
            expect(movieParam).to(beNil())
            expect(errorParam).to(equal(error))
          }
        }
      }
    }
  }
}
