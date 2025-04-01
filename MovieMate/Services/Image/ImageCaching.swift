//
//  ImageCaching.swift
//  MovieMate
//
//  Created by Karlis Berzins on 01/04/2025.
//

import Foundation
import UIKit

protocol ImageCaching {
    func image(for url: URL) async throws -> UIImage
}
