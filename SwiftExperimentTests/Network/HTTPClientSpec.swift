import Quick
import Nimble
import SwiftExperiment

typealias NSURLSessionDataTaskClosure = (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void

class HTTPClientSpec: QuickSpec {
  override func spec() {
    var subject: HTTPClient!
    let task = MockNSURLSessionDataTask()
    let session = MockNSURLSession(task: task)
    var sendRequestClosureWasCalled: Bool!
    var dataParam: NSData!
    var errorParam: NSError!

    beforeEach {
      session.resetSentMessages()
      task.resetSentMessages()
      sendRequestClosureWasCalled = false

      subject = HTTPClient(session: session)
    }

    describe("sendRequest") {
      var request: NSURLRequest!

      beforeEach {
        request = NSURLRequest()
        session.receivedDataTaskWithRequest = false
        subject.sendRequest(request) {
          (data, error) in
          sendRequestClosureWasCalled = true
          dataParam = data
          errorParam = error
        }
      }

      it("gets a task from the session") {
        expect(session.receivedDataTaskWithRequest).to(beTrue())
        expect(task).to(equal(session.task))
      }

      it("passes the request to the NSURLSession") {
        expect(session.dataTaskWithRequestParams.request).to(equal(request))
      }

      it("resumes the data task") {
        expect(task.receivedResume).to(beTruthy())
      }

      describe("when the data task returns") {
        context("successfully") {
          var data: NSData!
          var response: NSURLResponse!

          beforeEach {
            data = NSData()
            response = NSURLResponse()
            session.dataTaskWithRequestParams.completionHandler(data: data, response: response, error: nil)
          }

          it("calls its closure with the data") {
            expect(sendRequestClosureWasCalled).to(beTrue())
            expect(dataParam).to(equal(data))
            expect(errorParam).to(beNil())
          }
        }

        context("with error") {
          var error: NSError!

          beforeEach {
            error = NSError(domain: "", code: 0, userInfo: nil)
            session.dataTaskWithRequestParams.completionHandler(data: nil, response: nil, error: error)
          }

          it("calls its closure with the error") {
            expect(sendRequestClosureWasCalled).to(beTrue())
            expect(dataParam).to(beNil())
            expect(errorParam).to(equal(error))
          }
        }
      }
    }
  }
}
