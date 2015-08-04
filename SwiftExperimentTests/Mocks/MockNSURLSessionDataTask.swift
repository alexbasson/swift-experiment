import Foundation

class MockNSURLSessionDataTask: NSURLSessionDataTask {
  var resumeWasReceived = false

  override func resume() {
    resumeWasReceived = true
    return
  }
}

extension MockNSURLSessionDataTask: Mockable {
  func resetSentMessages() {
    resumeWasReceived = false
  }
}
