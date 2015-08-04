import Quick
import Nimble
import SwiftExperiment

class JSONClientSpec: QuickSpec {
  override func spec() {
    var subject: JSONClient!
    let httpClient = MockHTTPClient()
    var closureWasCalled: Bool!
    var request: NSURLRequest!
    var jsonParam: AnyObject!
    var errorParam: NSError!

    beforeEach {
      closureWasCalled = false
      subject = JSONClient(httpClient: httpClient)

      httpClient.resetSentMessages()

      request = NSURLRequest()
      closureWasCalled = false
      subject.sendRequest(request) {
        (json, error) in
        closureWasCalled = true
        jsonParam = json
        errorParam = error
      }
    }

    describe("sendRequest()") {
      it("messages the http client to send the request") {
        expect(httpClient.sendRequest.wasReceived).to(beTrue())
        expect(httpClient.sendRequest.params.request).to(beIdenticalTo(request))
      }

      describe("when the request returns") {
        context("successfully") {
          beforeEach {
            let data = "{}".dataUsingEncoding(NSUTF8StringEncoding)
            httpClient.sendRequest.params.closure(data: data, error: nil)
          }

          it("calls its closure with parsed json") {
            expect(closureWasCalled).to(beTrue())
            expect(errorParam).to(beNil())
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "JSONClientError", code: 0, userInfo: nil)
            httpClient.sendRequest.params.closure(data: nil, error: error)
          }

          it("calls its closure with the error") {
            expect(jsonParam).to(beNil())
            expect(errorParam).to(equal(error))
          }
        }
      }
    }
  }
}
