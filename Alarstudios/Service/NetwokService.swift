//
//  NetwokService.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

protocol NetwokServiceProtocol: AnyObject {
    func get(_ page: Int, _ sessionKey: String, _ complection: @escaping (Result<PageRequest.Response, CustomError>) -> Void)
    func signeIn(_ login: String, _ password: String, _  complection: @escaping (Result<LoginRequest.Response, CustomError>) -> Void)
    func loadImage(_ index: Int, _  complection: @escaping (Result<LoadImageRequest.Response, ImageLoadError>) -> Void)
}

final class NetwokService: NetwokServiceProtocol {
    let network = DefaultNetworkService()
}
