//
//  FakeNetworkManager.swift
//  PocketMonsterTests
//
//  Created by Bryan Andres  Almeida Flores on 26/04/2022.
//

import Foundation
import Combine
@testable import PocketMonster

class FakeNetworkManager : NetworkManager {
    
        var data : Data?
        var createurl : URL?
        var error: NSError?
    
        func getResponseType <Model>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, NetworkManager > where Model : Decodable {
    // is no error   exactly is just show throws NSError
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(model, from: data)
                    return CurrentValueSubject<Model, NetworkError>(result).eraseToAnyPublisher()
                } catch { }
            }
    
            if let error = error {
                return Fail<Model, NetworkError>(error: error).eraseToAnyPublisher()
            }
    
            return Fail<Model, NetworkError>(error: .badURL).eraseToAnyPublisher()
        }
    
        func getData(from url: String, completionHandler: @escaping (Data?) -> Void) {
            if let data = data {
                completionHandler(data)
            }
        }
    
    }

    
    
    
    
    
    
    
    
    
    
//
//    override func getResponseType<ResponseType: Decodable>(_ type: ResponseType.Type) async throws -> ResponseType {
//        let data =  getData()
//        let result = try JSONDecoder().decode(ResponseType.self, from: data)
//        return result
//    }
//
//    final override func getData() async throws -> Data {
//        let url = try createURL()
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return data
//    }
//
//    private func createURL() throws -> URL {
//        guard let url =  URL(string: self.url) else {
//            throw NSError(domain: "can not create url", code: 500)
//        }
//        return url
//    }
//
//}


//{
//
//    var data: Data?
//    var error: NSError?
//
//    func getResponseType <Model>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, NetworkError> where Model : Decodable {
//
//        if let data = data {
//            do {
//                let result = try JSONDecoder().decode(model, from: data)
//                return CurrentValueSubject<Model, NetworkError>(result).eraseToAnyPublisher()
//            } catch { }
//        }
//
//        if let error = error {
//            return Fail<Model, NetworkError>(error: error).eraseToAnyPublisher()
//        }
//
//        return Fail<Model, NetworkError>(error: .badURL).eraseToAnyPublisher()
//    }
//
//    func getData(from url: String, completionHandler: @escaping (Data?) -> Void) {
//        if let data = data {
//            completionHandler(data)
//        }
//    }
//
//}


