//
//  NetworkManager.swift
//  FoodOrder
//
//  Created by Матвей Авдеев on 19.10.2023.
//

import UIKit
import Kingfisher

enum Link {
    case categories
    case dish
    
    var url: URL {
        switch self {
        case .categories:
            return URL(string: "https://run.mocky.io/v3/b3e33160-24b4-4961-926f-6956d679551b")!
        case .dish:
            return URL(string: "https://run.mocky.io/v3/40cb72ab-cca2-403c-a0e5-a4863d74b038")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(_ type: T.Type, withUrl url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let networkData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(networkData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchImage(withUrl url: URL, andImage image: UIImageView) {
        image.kf.setImage(with: url)
    }
    
    private init() {}
}
