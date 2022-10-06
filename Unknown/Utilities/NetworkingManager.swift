//
//  NetworkingManager.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//


import Foundation
import Combine

class NetworkingManager{
    
    enum NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self{
            case .badURLResponse(url: let url):
                return "[😡] bad response from URL: \(url)"
            case .unknown :
                return "[😰] unknown error"
            }
        }
    }
    
    static func download(for url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // default 값이므로 없어도 무방함
            .tryMap({try handleOutput(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher() // return to AnyPublisher<Data, Error>
    }
    
    static func handleOutput(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
            
            // 여기서 error가 나면 handleCompletion에서 error을 받아서 출력함
        }

        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        
        switch completion{
        case .finished:
            break
        case .failure(let error) :
            print("error downloading data: \(error)")
        }
    }
}
