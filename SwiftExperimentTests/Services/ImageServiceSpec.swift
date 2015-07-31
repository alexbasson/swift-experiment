import Quick
import Nimble
import SwiftExperiment

extension UIImage {
  func isEqualToByBytes(otherImage: UIImage) -> Bool {
    let imagePixelsData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
    let otherImagePixelsData = CGDataProviderCopyData(CGImageGetDataProvider(otherImage.CGImage))
    if let imagePixelsData = imagePixelsData,
      otherImagePixelsData = otherImagePixelsData {
        return imagePixelsData == otherImagePixelsData
    } else {
      return false
    }

  }
}

class ImageServiceSpec: QuickSpec {
    override func spec() {
      var subject: ImageService!
      var httpClient: MockHTTPClient!

      beforeEach {
        httpClient = MockHTTPClient()

        subject = ImageService(httpClient: httpClient)
      }

      describe("fetchImage()") {
        var url: NSURL!
        var fetchedImage: UIImage!

        beforeEach {
          url = NSURL(string: "example.com")!
          subject.fetchImage(url: url) {
            (image) in
            fetchedImage = image
          }
        }

        it("messages the http client to make a request") {
          expect(httpClient.receivedSendRequest).to(beTruthy())
        }

        it("passes the request to the http client") {
          let request = httpClient.requestParam
          expect(request.URL).to(equal(url))
        }

        describe("when the request returns") {
          var closure: HTTPClientClosure!

          beforeEach {
            closure = httpClient.sendRequestClosure
          }

          context("successfully") {
            var image: UIImage!

            beforeEach {
              let testBundle = NSBundle(forClass: ImageServiceSpec.self)
              image = UIImage(named: "kitten.jpg", inBundle: testBundle, compatibleWithTraitCollection: nil)
              if let image = image {
                let data = UIImageJPEGRepresentation(image, 1.0)
                closure(data: data, error: nil)
              } else {
                XCTFail()
              }
            }

//            it("calls the closure with the image data") {
//              expect(fetchedImage.isEqualToByBytes(image)).to(beTruthy())
//            }
          }

          context("with error") {
            it("doesn't do anything") {
            }
          }
        }
      }
    }
}
