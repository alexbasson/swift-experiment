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
    override public func sendRequest(request: NSURLRequest, closure: (json: AnyObject) -> ()) {
        receivedSendRequest = true
        requestParam = request
        closure(json: ["movies": []])
    }
}

class MovieServiceSpec: QuickSpec {
    override func spec() {
        var subject: MovieService!
        var requestProvider: MockRequestProvider!
        var jsonClient: MockJSONClient!
        var closureWasCalled: Bool = false

        beforeEach {
            requestProvider = MockRequestProvider()
            jsonClient = MockJSONClient()
            subject = MovieService(requestProvider: requestProvider, jsonClient: jsonClient)

            expect(requestProvider.receivedGetMoviesRequest).to(beFalsy())
            expect(jsonClient.receivedSendRequest).to(beFalsy())

            closureWasCalled = false
            subject.getMovies {
                (movie: [Movie]) in
                closureWasCalled = true
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

            it("calls its closure") {
                expect(closureWasCalled).to(beTruthy())
            }
        }
    }
}
