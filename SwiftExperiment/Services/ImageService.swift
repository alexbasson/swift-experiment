import UIKit

public class ImageService: ImageServiceInterface {
  public static let sharedInstance = ImageService(httpClient: HTTPClient())

  let httpClient: HTTPClientInterface
  var images: Dictionary<NSURL, UIImage> = [:]

  public init(httpClient: HTTPClientInterface) {
    self.httpClient = httpClient
  }

  public func fetchImage(url url: NSURL, closure: ImageServiceClosure) {
    if let image = images[url] {
      print("returning cached image")
      closure(image: image)
    } else {
      print("fetching image from network")
      let request = NSURLRequest(URL: url)
      httpClient.sendRequest(request, closure: {
        (data, error) -> Void in
        if let
          data = data,
          image = UIImage(data: data) {
            self.images[url] = image
            closure(image: image)
        }
      })
    }
  }
}
