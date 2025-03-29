//
//  Movie+Preview.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation

extension Movie {
    static var previews: [Self] {
        let url = Bundle.main.url(forResource: "preview-movies", withExtension: "json")!
        let data = try! Data(contentsOf: url)

        return try! JSONDecoder().decode(Root.self, from: data).results
    }
}
