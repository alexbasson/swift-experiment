import Quick
import Nimble
import SwiftExperiment

class MovieServiceSpec: QuickSpec {
  override func spec() {
    var subject: MovieService!
    let requestProvider = MockRequestProvider()
    let jsonClient = MockJSONClient()
    var closureWasCalled: Bool = false

    beforeEach {
      jsonClient.resetSentMessages()
      requestProvider.resetSentMessages()
      closureWasCalled = false

      subject = MovieService(requestProvider: requestProvider, jsonClient: jsonClient)
    }

    describe("getMovies()") {
      var getMoviesParams: (movies: [Movie]?, error: NSError?)!
      var sendRequestParams: MockJSONClient.SendRequestParams!

      beforeEach {
        subject.getMovies {
          (movies, error) in
          closureWasCalled = true
          getMoviesParams = (movies: movies, error: error)
        }
        sendRequestParams = jsonClient.sendRequestInvocation.params as! MockJSONClient.SendRequestParams
      }

      it("gets the getMovies request from the request provider") {
        expect(requestProvider.getMoviesRequestInvocation.wasReceived).to(beTrue())
      }

      it("messages the json client to send the request") {
        expect(jsonClient.sendRequestInvocation.wasReceived).to(beTrue())
        expect(sendRequestParams.request).to(beIdenticalTo(requestProvider.fakeGetMoviesRequest))
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
            sendRequestParams.closure(json: json, error: nil)
          }

          it("calls its closure with the array of movies") {
            expect(closureWasCalled).to(beTruthy())
          }

          it("passes to the closure the array of movies") {
            expect(getMoviesParams.movies).to(equal([movie]))
          }

          it("passes to the closure a nil error") {
            expect(getMoviesParams.error).to(beNil())
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "MovieServiceError", code: 0, userInfo: nil)
            sendRequestParams.closure(json: nil, error: error)
          }

          it("calls its closure with the error") {
            expect(closureWasCalled).to(beTruthy())
          }

          it("passes to the closure a nil array of movies") {
            expect(getMoviesParams.movies).to(beNil())
          }

          it("passes to the closure the error") {
            expect(getMoviesParams.error).to(equal(error))
          }
        }
      }
    }
  }
}
