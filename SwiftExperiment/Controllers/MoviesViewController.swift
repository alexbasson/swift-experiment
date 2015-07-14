import UIKit

public class MoviesViewController: UIViewController {
    public var moviesView: MoviesView! { return self.view as! MoviesView }

    var movies = [Movie]()
    var movieService = MovieService()

    public func configureWithMovieService(movieService: MovieService) {
        self.movieService = movieService
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        movieService.getMovies() {
            (movies, error) in
            if let movies = movies {
                self.movies = movies
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    self.moviesView.tableView?.reloadData()
                })
            } else if let error = error {
                print(error)
                // do something with the error
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        return cell
    }
}
