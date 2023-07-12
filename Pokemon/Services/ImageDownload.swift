//
//  ImageDownload.swift
//  Pokemon
//
//  Created by Indah Nurindo on 12/07/2566 BE.
//

import UIKit

class ImageDownload{
    func downloadImage(url:URL) async throws -> UIImage{
        
        async let imageData: Data = try Data(contentsOf: url)
        return UIImage(data: try await imageData)!
    }
}
