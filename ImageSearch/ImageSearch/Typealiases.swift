//
//  Typealiases.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

// MARK: - Network

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]
typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()
typealias ResponseData = (data: Data?, urlResponse: URLResponse?, error: Error?)

