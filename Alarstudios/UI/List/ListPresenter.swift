//
//  ListPresenter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

protocol ListPresenterOutput {
    func showPage(_ list: [PageModel.Item])
    func showError(_ error: CustomError)
}

protocol ListPresenterInput {
    func openDetail(_ item: PageModel.Item)
    func loadNextPage()
}

final class ListPresenter {
    private let view: ListPresenterOutput
    private let router: ListRouter
    private let viewModel: ListViewModelInput
    init(view: ListPresenterOutput,
         router: ListRouter,
         viewModel: ListViewModelInput) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
}

extension ListPresenter: ListPresenterInput {
    func openDetail(_ item: PageModel.Item) {
        router.openItemDetail(item)
    }
    func loadNextPage() {
        viewModel.loadPage()
    }
}

extension ListPresenter: ListViewModelOutput {
    func showPage(_ list: [PageModel.Item]) {
        view.showPage(list)
    }
    func showError(_ error: CustomError) {
        view.showError(error)
    }
}
