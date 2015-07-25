import Quick
import Nimble
import SwiftExperiment

public class MockHTTPClient: HTTPClientInterface {
  public var receivedSendRequest = false
  public var requestParam: NSURLRequest!
  public var sendRequestClosure: HTTPClientClosure!

  public func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    receivedSendRequest = true
    requestParam = request
    sendRequestClosure = closure
  }
}

class JSONClientSpec: QuickSpec {
  override func spec() {
    var subject: JSONClient!
    var httpClient: MockHTTPClient!
    var closureWasCalled: Bool!
    var request: NSURLRequest!
    var jsonParam: AnyObject!
    var errorParam: NSError!

    beforeEach {
      closureWasCalled = false
      httpClient = MockHTTPClient()
      subject = JSONClient(httpClient: httpClient)

      expect(httpClient.receivedSendRequest).to(beFalsy())

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
        expect(httpClient.receivedSendRequest).to(beTruthy())
        expect(httpClient.requestParam).to(beIdenticalTo(request))
      }

      describe("when the request returns") {
        context("successfully") {
          beforeEach {
            let data = "{}".dataUsingEncoding(NSUTF8StringEncoding)
            httpClient.sendRequestClosure(data: data, error: nil)
          }

          it("calls its closure with parsed json") {
            expect(closureWasCalled).to(beTruthy())
            expect(errorParam).to(beNil())
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "JSONClientError", code: 0, userInfo: nil)
            httpClient.sendRequestClosure(data: nil, error: error)
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
