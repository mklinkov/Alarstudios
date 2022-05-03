//
//  ListPresenter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

protocol ListPresenterOutput: AnyObject {
    func showPage(_ list: [PageModel.Item])
    func showError(_ error: CustomError)
}

protocol ListPresenterInput: AnyObject {
    func openDetail(_ item: PageModel.Item)
    func loadNextPage()
}

final class ListPresenter {
    private weak var view: ListPresenterOutput?
    private let router: ListRouter
    private let listUseCase: LoadListsPageUseCase
    private var numberPage: Int = 0
    
    init(view: ListPresenterOutput,
         router: ListRouter,
         listUseCase: LoadListsPageUseCase) {
        self.view = view
        self.router = router
        self.listUseCase = listUseCase
    }
}

extension ListPresenter: ListPresenterInput {
    func openDetail(_ item: PageModel.Item) {
        router.openItemDetail(item)
    }
    func loadNextPage() {
        loadPage()
    }
}

extension ListPresenter {
    func showPage(_ list: [PageModel.Item]) {
        view?.showPage(list)
    }
    func showError(_ error: CustomError) {
        view?.showError(error)
    }
}

extension ListPresenter {
    private func loadPage() {
        listUseCase.invoke(numberPage) { [weak self] result in
            self?.numberPage += 1
            guard let self = self else { return }
            switch result {
            case .success(let newPage):
                self.showPage(newPage)
            case.failure(let error):
                self.showError(error)
            }
        }
    }
}
