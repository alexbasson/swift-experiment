import UIKit

public class MoviesViewController: UIViewController {
  public var moviesView: MoviesView! { return self.view as! MoviesView }

  var movies = [Movie]()
  var movieService: MovieServiceInterface = MovieService()
  var imageService: ImageServiceInterface = ImageService()

  public func configure(movieService movieService: MovieServiceInterface, imageService: ImageServiceInterface) {
    self.movieService = movieService
    self.imageService = imageService
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

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowMovieDetailSegue" {
      if let
        tableView = moviesView.tableView,
        cell = sender as? UITableViewCell,
        indexPath = tableView.indexPathForCell(cell) {
          let movie = movies[indexPath.row]
          let movieDetailViewController = segue.destinationViewController as? MovieDetailViewController
          if let movieDetailViewController = movieDetailViewController {
            movieDetailViewController.configure(movie: movie)
          }
      }
    }
  }
}

extension MoviesViewController: UITableViewDataSource {
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(MovieTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! MovieTableViewCell
    let movie = movies[indexPath.row]
    cell.titleLabel.text = movie.title
    imageService.fetchImage(url: movie.thumbnailURL) {
      (image) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        () -> Void in
        cell.thumbnailImageView.image = image
      })
    }
    return cell
  }
}
