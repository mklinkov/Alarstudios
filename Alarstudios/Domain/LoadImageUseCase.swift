//
//  LoadImageUseCase.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
import UIKit

/// UseCase - единица бизнеслогики
/// UseCase может инжектить только репозитории
/// UseCase имеет одну публичную функцию invoke
/// UseCase должен быть покрыт юнит тестами
final class LoadImageUseCase {
    private let imageRepository: ImageRepository
    
    init(_ imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func invoke(_ index: Int, _ complection: @escaping (UIImage?) -> ()) {
        imageRepository.loadRandomImage(index) { result in
            switch result {
            case .failure:
                complection(nil)
            case .success(let image):
                complection(image)
            }
        }
    }
}
