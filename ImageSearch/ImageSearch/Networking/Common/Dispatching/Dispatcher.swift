//
//  Network.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

class Dispatcher {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func performRequest(_ request: URLRequest, completion: @escaping (_ responseData: ResponseData) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            completion((data, response, error))
        }.resume()
    }
    
}
