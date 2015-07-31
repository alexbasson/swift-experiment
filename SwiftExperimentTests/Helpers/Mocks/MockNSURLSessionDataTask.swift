import Foundation
import SwiftExperiment

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
