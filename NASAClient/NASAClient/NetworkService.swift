//
//  NetworkService.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 02.01.2022.
//

import Foundation

class NetworkService {
    
    func jsonPhotosRequest(urlString: String, completion: @escaping (Result<PhotosResponse, Error>) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
            
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let jsonResponse = try decoder.decode(PhotosResponse.self, from: data)

                    completion(.success(jsonResponse))
                    
                } catch {
                    print(error)
                    completion(.failure(error))
                }
                
            }
            
        }.resume()

    }
    
    
    func jsonRoverDataRequest(urlString: String, completion: @escaping (Result<RoverDataResponse, Error>) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
            
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let jsonResponse = try decoder.decode(RoverDataResponse.self, from: data)

                    completion(.success(jsonResponse))
                    
                } catch {
                    print(error)
                    completion(.failure(error))
                }
                
            }
            
        }.resume()

    }
    
}
