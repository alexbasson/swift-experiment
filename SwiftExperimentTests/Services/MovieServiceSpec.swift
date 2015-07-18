import Quick
import Nimble
import SwiftExperiment

public class MockRequestProvider: RequestProvider {
  public var receivedGetMoviesRequest = false
  public let fakeGetMoviesRequest = NSURLRequest()

  override public func getMoviesRequest() -> NSURLRequest? {
    receivedGetMoviesRequest = true
    return fakeGetMoviesRequest
  }
}

public class MockJSONClient: JSONClient {
  public var receivedSendRequest = false
  public var requestParam: NSURLRequest!
  public var sendRequestClosure: JSONClientClosure!

  override public func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    receivedSendRequest = true
    requestParam = request
    sendRequestClosure = closure
  }
}

public class MockMovieSerializer: MovieSerializer {
}

class MovieServiceSpec: QuickSpec {
  override func spec() {
    var subject: MovieService!
    var requestProvider: MockRequestProvider!
    var jsonClient: MockJSONClient!
    var movieSerializer: MockMovieSerializer!
    var closureWasCalled: Bool = false
    var movieParam: [Movie]!
    var errorParam: NSError!

    beforeEach {
      requestProvider = MockRequestProvider()
      jsonClient = MockJSONClient()
      movieSerializer = MockMovieSerializer()

      subject = MovieService(requestProvider: requestProvider, jsonClient: jsonClient, movieSerializer: movieSerializer)

      expect(requestProvider.receivedGetMoviesRequest).to(beFalsy())
      expect(jsonClient.receivedSendRequest).to(beFalsy())

      closureWasCalled = false
      subject.getMovies {
        (movie, error) in
        closureWasCalled = true
        movieParam = movie
        errorParam = error
      }
    }

    describe("getMovies()") {
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
            let json = ["movies": [
              ["title": "A movie"]
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
