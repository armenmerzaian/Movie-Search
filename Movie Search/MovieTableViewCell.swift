//
//  MovieTableViewCell.swift
//  Movie Search
//
//  Created by Armen on 2023-07-21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    func configureCell(with movie: BasicMovie) {
        movieTitle.text = movie.title
        movieYear.text = movie.year
        
        posterImage.layer.cornerRadius = 8;
        
        if let posterURL = URL(string: movie.poster) {
            posterImage.load(url: posterURL)
        }
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
