import Foundation
import SwiftExperiment

extension Posters {

  public convenience init() {
    self.init(thumbnailURL: NSURL(string: "example.com/posters/thumbnail")!,
              profileURL: NSURL(string: "example.com/posters/profile")!,
              detailedURL: NSURL(string: "example.com/posters/detailed")!,
              originalURL: NSURL(string: "example.com/posters/original")!)
  }
}
