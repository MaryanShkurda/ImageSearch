//
//  NetworkResponse.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case failed = "Network request failed."
    case clientSideError = "Client side error."
    case serverSideError = "Server side error."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}
