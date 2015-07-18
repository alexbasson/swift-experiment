import Foundation

public typealias MovieServiceClosure = (movies: [Movie]?, error: NSError?) -> ()

public class MovieService {
  let requestProvider: RequestProvider
  let jsonClient: JSONClient
  let movieSerializer: MovieSerializer

  public init(requestProvider: RequestProvider, jsonClient: JSONClient, movieSerializer: MovieSerializer) {
    self.requestProvider = requestProvider
    self.jsonClient = jsonClient
    self.movieSerializer = movieSerializer
  }

  public convenience init() {
    self.init(requestProvider: RequestProvider(), jsonClient: JSONClient(), movieSerializer: MovieSerializer())
  }

  public func getMovies(closure: MovieServiceClosure) {
    if let request = requestProvider.getMoviesRequest() {
      jsonClient.sendRequest(request) {
        (json, error) in
        if let json = json {
          if let moviesJson = json["movies"] as? NSArray {
            let movies: NSMutableArray = []
            for movieJson in moviesJson {
              let movie = self.movieSerializer.deserialize(movieJson as! Dictionary<String, AnyObject>)
              movies.addObject(movie)
            }
            closure(movies: movies as NSArray as? [Movie], error: nil)
          }
        } else if let error = error {
          closure(movies: nil, error: error)
        }
      }
    }
  }
}
