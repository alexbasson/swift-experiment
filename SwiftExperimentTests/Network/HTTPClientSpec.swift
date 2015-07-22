import Quick
import Nimble
import SwiftExperiment

typealias NSURLSessionDataTaskClosure = (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void

class MockNSURLSessionDataTask: NSURLSessionDataTask {
  var receivedResume = false

  override func resume() {
    receivedResume = true
    return
  }
}

class MockNSURLSession: NSURLSession {
  var receivedDataTaskWithRequest: Bool = false
  var requestParam: NSURLRequest!
  var dataTaskClosure: NSURLSessionDataTaskClosure!

  let task: MockNSURLSessionDataTask

  init(task: MockNSURLSessionDataTask) {
    self.task = task
  }

  override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    receivedDataTaskWithRequest = true
    requestParam = request
    dataTaskClosure = completionHandler
    return task
  }
}

class HTTPClientSpec: QuickSpec {
    override func spec() {
      var subject: HTTPClient!
      var session: MockNSURLSession!
      var sendRequestClosureWasCalled: Bool!
      var dataParam: NSData!
      var errorParam: NSError!
      var task: MockNSURLSessionDataTask!

      beforeEach {
        sendRequestClosureWasCalled = false

        task = MockNSURLSessionDataTask()
        session = MockNSURLSession(task: task)
        subject = HTTPClient(session: session)
      }

      describe("sendRequest") {
        var request: NSURLRequest!

        beforeEach {
          request = NSURLRequest()
          subject.sendRequest(request) {
            (data, error) in
            sendRequestClosureWasCalled = true
            dataParam = data
            errorParam = error
          }
        }

        it("gets a task from the session") {
          expect(session.receivedDataTaskWithRequest).to(beTruthy())
          expect(task).to(equal(session.task))
        }

        it("passes the request to the NSURLSession") {
          expect(session.requestParam).to(equal(request))
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
              session.dataTaskClosure(data: data, response: response, error: nil)
            }

            it("calls its closure with the data") {
              expect(sendRequestClosureWasCalled).to(beTruthy())
              expect(dataParam).to(equal(data))
              expect(errorParam).to(beNil())
            }
          }

          context("with error") {
            var error: NSError!

            beforeEach {
              error = NSError(domain: "", code: 0, userInfo: nil)
              session.dataTaskClosure(data: nil, response: nil, error: error)
            }

            it("calls its closure with the error") {
              expect(sendRequestClosureWasCalled).to(beTruthy())
              expect(dataParam).to(beNil())
              expect(errorParam).to(equal(error))
            }
          }
        }
      }
    }
}
