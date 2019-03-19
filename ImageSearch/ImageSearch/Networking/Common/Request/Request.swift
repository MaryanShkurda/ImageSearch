//
//  Request.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

protocol Request {
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    
    func asURLRequest() -> URLRequest
}
