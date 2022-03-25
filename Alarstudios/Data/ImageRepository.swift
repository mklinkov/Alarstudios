//
//  ImageRepository.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
import UIKit

/// Протокол репозитори загрузки изображений
/// отвественность репозитория это выбор источника информации сеть, память, база
/// репозиторий  абстракция чтобы логика была изолирована от источника данных
/// репозиторий всегда описывается через протокол
/// в репозитории всегда возврает результат в main
protocol ImageRepositoryProtocol {
    func loadRandomImage(_ index: Int, _ complection: @escaping (Result<UIImage, ImageLoadError>) -> Void)
}

enum ImageLoadError: Error {
    case errorLoadImage
}

final class ImageRepository: ImageRepositoryProtocol {
    private var network: NetwokServiceProtocol
    private weak var store: ImageInmemoryStoreProtocol?
    init(network: NetwokServiceProtocol,
         store: ImageInmemoryStoreProtocol) {
        self.network = network
        self.store = store
    }
    
    func loadRandomImage(_ index: Int, _ complection: @escaping (Result<UIImage, ImageLoadError>) -> Void) {
        if let image = store?.getImage(index: index) {
            return complection(.success(image))
        }
        network.loadImage(index) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.store?.saveImage(index: index, image: image)
                case.failure:
                    break
                }
                complection(result)
            }
        }
    }
}

protocol ImageInmemoryStoreProtocol: AnyObject {
    func saveImage(index: Int, image: UIImage)
    func getImage(index: Int) -> UIImage?
}

/// хранилище в памяти, можно заменить на любой вариант хранения
final class ImageInmemoryStore: ImageInmemoryStoreProtocol {
    static let instance = ImageInmemoryStore.init()
    private var listOfImage: [Int: UIImage] = [:]
    private init() { }
    
    func saveImage(index: Int, image: UIImage) {
        listOfImage[index] = image
    }
    
    func getImage(index: Int) -> UIImage? {
        listOfImage[index]
    }
}
