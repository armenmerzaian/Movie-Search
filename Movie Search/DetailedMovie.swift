//
//  DetailedMovie.swift
//  Movie Search
//
//  Created by Armen on 2023-07-21.
//

import Foundation

class DetailedMovie: Codable {
    var title: String;
    var year: String;
    var rated: String;
    var runtime: String;
    var genre: String;
    var plot: String;
    var poster: String;
    var ratings: [Rating];
    var imdbID: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.rated = try container.decode(String.self, forKey: .rated)
        self.runtime = try container.decode(String.self, forKey: .runtime)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.plot = try container.decode(String.self, forKey: .plot)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.ratings = try container.decode([Rating].self, forKey: .ratings)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case runtime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case poster = "Poster"
        case ratings = "Ratings"
        case imdbID = "imdbID"
    }
}

class Rating: Codable {
    var source: String;
    var value: String;
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(String.self, forKey: .source)
        self.value = try container.decode(String.self, forKey: .value)
    }
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

