//
//  LoadListsPageUseCase.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

/// UseCase - единица бизнеслогики
/// UseCase может инжектить только репозитории
/// UseCase имеет одну публичную функцию invoke
/// UseCase должен быть покрыт юнит тестами
final class LoadListsPageUseCase {
    private let listRepository: ListRepositoryProtocol
    private let loginRepository: LoginRepositoryProtocol
    init(listRepository: ListRepositoryProtocol,
         loginRepository: LoginRepositoryProtocol) {
        self.listRepository = listRepository
        self.loginRepository = loginRepository
    }
    /// метод получение страницы списка invoke(_ page: Int, _ complection: (Result<String, CustomError>) -> Void)
    /// - Parameters:
    ///  - page: номер страницы
    ///  - complection:  блок выполнения
    func invoke(_ page: Int, _ complection: @escaping (Result<PageRequest.Response, CustomError>) -> Void) {
        guard let sessionKey = loginRepository.getSessionKey() else {
            return complection(.failure(.sessionNotfound))
        }
        listRepository.get(page, sessionKey, complection)
    }
}
