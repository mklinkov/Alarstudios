//
//  NetwokService+loadImage.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
import UIKit

struct LoadImageRequest: DataRequest {
    /// https://source.unsplash.com - это севис рандомных изображения контент зависит только от сервиса
    var url: String = "https://source.unsplash.com/200x200/?nature"
    var method: HTTPMethod = .get
    let sig: Int
    typealias Response = UIImage
    
    var queryItems: [String : String] {
        ["sig": "\(sig)"]
    }
    
    func decode(_ data: Data) throws -> UIImage {
        
        if let image = UIImage(data: data) {
            return image
        }
        
        assertionFailure("Failure decode image")
        return UIImage()
    }
}

extension NetwokService {
    func loadImage(_ index: Int, _  complection: @escaping (Result<LoadImageRequest.Response, ImageLoadError>)->()) {
        let request = LoadImageRequest(sig: index)
        network.request(request) { response in
            switch response {
            case.success( let result ):
                complection(.success(result))
            case .failure:
                complection(.failure(.errorLoadImage))
            }
        }
    }
}
