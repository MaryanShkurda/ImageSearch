//
//  FlickrRequest.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

enum FlickrRequest: Request {
    
    case recent(perPage: Int, page: Int)
    case search(perPage: Int, page: Int, text: String)
    
    private enum QueryItem: String {
        case apiKey = "api_key"
        case method = "method"
        case text = "text"
        case perPage = "per_page"
        case page = "page"
        case format = "format"
        case noJsonCallBack = "nojsoncallback"
    }
    
    private enum Method: String {
        case search = "flickr.photos.search"
        case recent = "flickr.photos.getRecent"
    }
    
    private enum Format: String {
        case json
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.flickr.com/") else { fatalError("❗️invalid baseURL")}
        return url
    }
    
    var path: String {
        return "services/rest"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type" : "application/json"]
    }
    
    var requiredParams: Parameters {
        return [QueryItem.format.rawValue : Format.json.rawValue, QueryItem.noJsonCallBack.rawValue : "1", QueryItem.apiKey.rawValue : Credentials.Flickr.key]
    }
    
    func asURLRequest() -> URLRequest {
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        var params = Parameters()
        
        switch self {
        case .search(perPage: let perPage, page: let page, text: let text):
            params = [QueryItem.method.rawValue : Method.search.rawValue, QueryItem.perPage.rawValue : perPage, QueryItem.page.rawValue : page, QueryItem.text.rawValue : text]
        case .recent(perPage: let perPage, page: let page):
            params = [QueryItem.method.rawValue : Method.recent.rawValue, QueryItem.perPage.rawValue : perPage, QueryItem.page.rawValue : page]
        }
        
        return urlRequest.encode(withURLParameters: params.mergedWith(requiredParams, keepFirst: true))
    }
    
}

extension URLRequest {
    mutating func encode(withURLParameters parameters: Parameters) -> URLRequest {
        
        guard let url = self.url else { fatalError("❗️ URLRequest hasn't URL") }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            self.url = urlComponents.url
        }
        return self
    }
}

extension Dictionary {
    static func += <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
    
    func mergedWith(_ another: Dictionary, keepFirst: Bool) -> Dictionary {
        var result = self
        if keepFirst {
            for (k, v) in another {
                if result[k] == nil {
                    result[k] = v
                }
            }
        } else {
            for (k, v) in another {
                result[k] = v
            }
        }
        return result
    }
}

