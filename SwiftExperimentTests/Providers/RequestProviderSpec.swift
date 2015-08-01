import Quick
import Nimble
import SwiftExperiment

class RequestProviderSpec: QuickSpec {
    override func spec() {
      var subject: RequestProvider!

      beforeEach {
        subject = RequestProvider()
      }

      describe("getMoviesRequest()") {
        it("returns a request to get movies") {
          if let request = subject.getMoviesRequest() {
            let url = NSURL(string: "http://localhost:8000/movies.json?apikey=none")
            expect(request.URL).to(equal(url))
          } else {
            XCTFail()
          }
        }
      }
    }
}
