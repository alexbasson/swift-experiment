import Quick
import Nimble
import SwiftExperiment

class ImageServiceSpec: QuickSpec {
    override func spec() {
      var subject: ImageService!
      var httpClient: MockHTTPClient!

      beforeEach {
        httpClient = MockHTTPClient()

        subject = ImageService(httpClient: httpClient)
      }

      describe("fetchImage()") {
        beforeEach {
          let url = NSURL(string: "example.com")!
          subject.fetchImage(url: url) {
            (image) in
          }
        }
      }
    }
}
