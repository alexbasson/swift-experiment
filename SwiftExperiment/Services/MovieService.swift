import Foundation

public class MovieService: MovieServiceInterface {
  let requestProvider: RequestProvider
  let jsonClient: JSONClientInterface

  public init(requestProvider: RequestProvider, jsonClient: JSONClientInterface) {
    self.requestProvider = requestProvider
    self.jsonClient = jsonClient
  }

  public convenience init() {
    self.init(requestProvider: RequestProvider(), jsonClient: JSONClient())
  }

  public func getMovies(closure: MovieServiceClosure) {
    if let request = requestProvider.getMoviesRequest() {
      jsonClient.sendRequest(request) {
        (json, error) in
        if let
          json = json,
          moviesJSON = json["movies"] as? [Dictionary<String, AnyObject>] {
            var movies: [Movie] = []
            for movieJSON in moviesJSON {
              let movie = Movie(dict: movieJSON)
              movies.append(movie)
            }
            closure(movies: movies, error: nil)
        } else if let error = error {
          closure(movies: nil, error: error)
        }
      }
    }
  }
}
