//
//  PhotoElement.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/19/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import UIKit

struct FlickrResponse: Codable {
    let data: PhotosData
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case data = "photos"
        case stat = "stat"
    }
}

struct PhotosData: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photoElements: [PhotoElement]
    private let totalStr: String
    
    var total: Int {
        return Int(totalStr) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case photoElements = "photo"
        case totalStr = "total"
    }
}

class PhotoElement: Codable {
    var id: String
    private var secret: String
    private var server: String
    private var farm: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
    }
    
    enum Size: String {
        case m
    }
    
    func getURL(_ size: Size = .m) -> URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            return url
        }
        return nil
    }
    
}
