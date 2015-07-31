import Foundation
import SwiftExperiment

public class MockImageService: ImageServiceInterface {
  public var receivedFetchImage = false
  public var fetchImageURLParam: NSURL!
  public var fetchImageClosure: ImageServiceClosure!

  public func fetchImage(url url: NSURL, closure: ImageServiceClosure) {
    receivedFetchImage = true
    fetchImageURLParam = url
    fetchImageClosure = closure
  }
}