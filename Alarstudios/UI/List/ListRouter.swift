//
//  ListRouter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

final class ListRouter: Router {
    func openItemDetail(_ item: PageModel.Item) {
        let detailViewController = DetailViewController.loadFromNib()
        
        let presenter = DetailPresenter(view: detailViewController, viewModel: item)
        detailViewController.presenter = presenter
        push(detailViewController)
    }
}
