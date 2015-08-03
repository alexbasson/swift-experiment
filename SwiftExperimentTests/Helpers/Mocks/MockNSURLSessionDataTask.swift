import Foundation
import SwiftExperiment

class MockNSURLSessionDataTask: NSURLSessionDataTask {
  var receivedResume = false

  override func resume() {
    receivedResume = true
    return
  }
}

extension MockNSURLSessionDataTask: Mockable {
  func resetSentMessages() {
    receivedResume = false
  }
}

class MockNSURLSession: NSURLSession {
  var receivedDataTaskWithRequest: Bool = false
  var dataTaskWithRequestParams: (request: NSURLRequest, completionHandler: NSURLSessionDataTaskClosure)!

  let task: MockNSURLSessionDataTask

  init(task: MockNSURLSessionDataTask) {
    self.task = task
  }

  override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    receivedDataTaskWithRequest = true
    dataTaskWithRequestParams = (request: request, completionHandler: completionHandler)
    return task
  }
}

extension MockNSURLSession: Mockable {
  func resetSentMessages() {
    receivedDataTaskWithRequest = false
  }
}
