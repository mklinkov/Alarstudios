//
//  NetwokService+Page.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

struct PageRequest: DataRequest {
    var url: String = "https://www.alarstudios.com/test/data.cgi"
    var method: HTTPMethod = .get
    let sessionKey: String
    let page: Int
    typealias Response = [PageModel.Item]
    
    var queryItems: [String: String] {
        ["code": sessionKey,
         "p": "\(page)"]
    }
    
    init(_ sessionKey: String, _ page: Int) {
        self.sessionKey = sessionKey
        self.page = page
    }
    
    func decode(_ data: Data) throws -> [PageModel.Item] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(PageModel.self, from: data)
        return response.data
    }
}

struct PageModel: Decodable {
    enum PageModelStatus: String, Decodable {
        case ok
        case error
    }
    
    let status: PageModelStatus
    let page: Int
    let data: [Item]
    
    struct Item: Decodable {
        let id: String
        let name: String
        let country: String
        let lat: Double
        let lon: Double
    }
}

extension NetwokService {
    func get(_ page: Int, _ sessionKey: String, _ complection: @escaping (Result<PageRequest.Response, CustomError>) -> Void) {
        let request = PageRequest(sessionKey, page)
        network.request(request) { result in
            switch result {
            case .success(let response):
                complection(.success(response))
            case .failure(let error):
                complection(.failure(.netwokError(error)))
            }
        }
    }
}
