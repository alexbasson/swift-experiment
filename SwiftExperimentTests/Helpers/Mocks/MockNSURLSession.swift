import Foundation
import SwiftExperiment

class MockNSURLSession: NSURLSession {
  typealias dataTaskWithRequestTuple = (wasReceived: Bool, params: (request: NSURLRequest!, completionHandler: NSURLSessionDataTaskClosure!))

  let task: MockNSURLSessionDataTask

  init(task: MockNSURLSessionDataTask) {
    self.task = task
  }

  var dataTaskWithRequest: dataTaskWithRequestTuple = (wasReceived: false, params: (request: nil, completionHandler: nil))
  override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    dataTaskWithRequest = (wasReceived: true, params: (request: request, completionHandler: completionHandler))
    return task
  }
}

extension MockNSURLSession: Mockable {
  func resetSentMessages() {
    dataTaskWithRequest = (wasReceived: false, params: (request: nil, completionHandler: nil))
  }
}
