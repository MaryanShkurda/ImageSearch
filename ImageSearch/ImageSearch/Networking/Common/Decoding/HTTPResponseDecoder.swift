//
//  ResponseHandler.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import UIKit

class HTTPResponseDecoder {
    
    static func decode<DataType: Decodable>(responseData: ResponseData, type: DataType.Type) -> (decoded: DataType?, errorMessage: String?) {
        
        if responseData.error != nil {
            return (nil, "Please, check your network connection.")
        }
        if let response = responseData.urlResponse as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = responseData.data else {
                    return (nil, NetworkResponse.noData.rawValue)
                }
                do {
                    let apiResponse = try JSONDecoder().decode(DataType.self, from: responseData)
                    return (apiResponse, nil)
                }catch {
                    print(error)
                    return (nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                return (nil, networkFailureError)
            }
        }
        return (nil, NetworkResponse.failed.rawValue)
    }
    
    private static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 400...499: return .failure(NetworkResponse.clientSideError.rawValue)
        case 500...599: return .failure(NetworkResponse.serverSideError.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
