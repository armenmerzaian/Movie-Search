//
//  MovieDetailsViewController.swift
//  Movie Search
//
//  Created by Armen on 2023-07-21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var metacriticLogo: UIImageView!
    @IBOutlet weak var rottenTomatoLogo: UIImageView!
    @IBOutlet weak var imdbLogo: UIImageView!
    
    @IBOutlet weak var metacriticRating: UILabel!
    @IBOutlet weak var rottenTomatoRating: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieRated: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    
    var imdbID: String?;
    var detailedMovie: DetailedMovie?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        guard let imdbID = imdbID else { return }
        fetchData(with: imdbID)
        
        posterImage.layer.cornerRadius = 8;
        
        // from Wimukthi Rajapaksha : https://stackoverflow.com/questions/40405798/add-a-gradient-on-uiimageview
        let gradient = CAGradientLayer()
        gradient.frame = posterImage.bounds
        gradient.contents = posterImage.image?.cgImage
        gradient.colors = [UIColor.black.cgColor, UIColor.black.withAlphaComponent(0)]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        posterImage.layer.addSublayer(gradient)
        // from Wimukthi Rajapaksha : https://stackoverflow.com/questions/40405798/add-a-gradient-on-uiimageview
        
        posterImage.isHidden = true;
        metacriticLogo.isHidden = true;
        rottenTomatoLogo.isHidden = true;
        imdbLogo.isHidden = true;
        metacriticRating.isHidden = true;
        rottenTomatoRating.isHidden = true;
        imdbRating.isHidden = true;
        moviePlot.isHidden = true;
        movieGenre.isHidden = true;
        movieRuntime.isHidden = true;
        movieRated.isHidden = true;
        movieYear.isHidden = true;
        movieTitle.isHidden = true;
        
    }
    
    func fetchData(with imdbID: String) {
        ApiHandler.shared.getByID(withQuery: imdbID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let detailedMovie):
                    self?.detailedMovie = detailedMovie
                    self?.configureView()
                case .failure(let error):
                    print("Error fetching detailed movie: \(error)")
                    self?.movieTitle.text = "Error fetching movie data"
                }
            }
        }
    }
    
    func configureView() {
        guard let detailedMovie = detailedMovie else {
            print("error")
            return
        }
        
        if let posterURL = URL(string: detailedMovie.poster) {
            posterImage.load(url: posterURL)
            posterImage.isHidden = false;
        }
        
        
        metacriticLogo.isHidden = false;
        rottenTomatoLogo.isHidden = false;
        imdbLogo.isHidden = false;
        
        metacriticRating.text = detailedMovie.ratings[2].value
        metacriticRating.isHidden = false;
        rottenTomatoRating.text = detailedMovie.ratings[1].value
        rottenTomatoRating.isHidden = false;
        imdbRating.text = detailedMovie.ratings[0].value
        imdbRating.isHidden = false;
        
        moviePlot.text = detailedMovie.plot
        moviePlot.isHidden = false;
        
        movieGenre.text = detailedMovie.genre
        movieGenre.isHidden = false;
        
        movieRuntime.text = detailedMovie.runtime
        movieRuntime.isHidden = false;
        
        movieRated.text = detailedMovie.rated
        movieRated.isHidden = false;
        
        movieYear.text = detailedMovie.year
        movieYear.isHidden = false;
        
        movieTitle.text = detailedMovie.title
        movieTitle.isHidden = false;
        
        print(detailedMovie.title)
    }
    
    
    
}
