//
//  ListRouter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

final class ListRouter: Router {
    func openItemDetail(_ item: PageModel.Item) {
        let viewModel = DetailViewModel(item)
        let detailViewController = DetailViewController.loadFromNib()
        
        let presenter = DetailPresenter(view: detailViewController, viewModel: viewModel)
        viewModel.presenter = presenter
        detailViewController.presenter = presenter
        push(detailViewController)
    }
}
