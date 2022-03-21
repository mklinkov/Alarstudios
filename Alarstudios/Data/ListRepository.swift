//
//  ListRepository.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

/// Репозиторий получения новой страницы
/// отвественность репозитория это выбор источника информации сеть, память, база
/// репозиторий  абстракция чтобы логика была изолирована от источника данных
/// репозиторий всегда описывается через протокол
/// в репозитории всегда возврает результат в main
protocol ListRepositoryProtocol {
    func get(_ page: Int, _ sessionKey: String, _ complection: @escaping (Result<PageRequest.Response, CustomError>)->())
}

final class ListRepository: ListRepositoryProtocol {
    private let dataSource: NetwokService
    init(dataSource: NetwokService){
        self.dataSource = dataSource
    }
    
    func get(_ page: Int, _ sessionKey: String, _ complection: @escaping (Result<PageRequest.Response, CustomError>)->()) {
        dataSource.get(page, sessionKey) { result in
            DispatchQueue.main.async {
                complection(result)
            }
        }
    }
}
