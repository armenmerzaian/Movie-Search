//
//  BasicMovie.swift
//  Movie Search
//
//  Created by Armen on 2023-07-21.
//

import Foundation

class SearchObject: Codable {
    
    var search: [BasicMovie] = []
    var totalResults: String = ""
    var response: String = ""
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decode([BasicMovie].self, forKey: .search)
        self.totalResults = try container.decode(String.self, forKey: .totalResults)
        self.response = try container.decode(String.self, forKey: .response)
    }
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

class BasicMovie: Codable{
    var title: String = ""
    var year: String = ""
    var imdbID: String = ""
    var type: String = ""
    var poster: String = ""
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.type = try container.decode(String.self, forKey: .type)
        self.poster = try container.decode(String.self, forKey: .poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

