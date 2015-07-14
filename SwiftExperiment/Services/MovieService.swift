import Foundation

public typealias MovieServiceClosure = (movies: [Movie]?, error: NSError?) -> ()

public class MovieService {
    let requestProvider: RequestProvider
    let jsonClient: JSONClient

    public init(requestProvider: RequestProvider, jsonClient: JSONClient) {
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
                if let json = json {
                    if let moviesJson = json["movies"] as? NSArray {
                        let movies: NSMutableArray = []
                        for movieJson in moviesJson {
                            if let title = movieJson["title"] as? String {
                                movies.addObject(Movie(title: title))
                            }
                        }
                        closure(movies: movies as NSArray as? [Movie], error: nil)
                    }
                } else if let error = error {
                    print(error)
                    // do something with the error
                }
            }
        }
    }
}
