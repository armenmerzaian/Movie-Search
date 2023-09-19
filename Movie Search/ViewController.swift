//
//  ViewController.swift
//  Movie Search
//
//  Created by Armen on 2023-07-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    
    var fetchSearchResult: [BasicMovie]?;
    
    @IBAction func performSearch(_ sender: Any) {
        
        guard searchBar.searchTextField.text != "" else {return}
        
        searchButton.isEnabled = false;
        
        fetchBasicMovies(withQuery: searchBar.searchTextField.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = "Find a movie...";
        self.movieTableView.isHidden = true;
        self.searchButton.layer.cornerRadius = 8;
        self.searchButton.layer.masksToBounds = true;
        
        movieTableView.dataSource = self;
        movieTableView.delegate = self;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetailSegue" {
            if let imdbID = sender as? String,
               let destinationVC = segue.destination as? MovieDetailsViewController {
                destinationVC.imdbID = imdbID
            }
        }
    }
    
    func fetchBasicMovies(withQuery: String) {
        ApiHandler.shared.getBySearch(withQuery: withQuery, page: 1) { result in
            switch result {
            case .success(let search):
                self.enableButtonAndSetDataSource(with: search)
            case .failure(let error):
                self.enableButtonAndSetPostLabel(with: error.rawValue)
            }
        }
    }
    
    
    func enableButtonAndSetDataSource(with value: SearchObject) {
        DispatchQueue.main.async { [self] in
            self.label.isHidden = true;
            self.fetchSearchResult = value.search;
            
            movieTableView.reloadData();
            self.searchButton.isEnabled = true
            self.movieTableView.isHidden = false;
        }
    }
    
    func enableButtonAndSetPostLabel(with value: String) {
        DispatchQueue.main.async {
            self.label.isHidden = false;
            self.label.text = value
            self.searchButton.isEnabled = true
            self.movieTableView.isHidden = true;
        }
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchSearchResult?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        if let movie = fetchSearchResult?[indexPath.row]{
            cell.configureCell(with: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovieDetailSegue", sender: fetchSearchResult?[indexPath.row].imdbID)
    }
}



