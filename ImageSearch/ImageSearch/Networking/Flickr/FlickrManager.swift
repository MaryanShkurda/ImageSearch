//
//  FlickrManager.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

class FlickrManager {
    
    private let dispatcher: Dispatcher
    
    init(session: URLSession = URLSession.shared) {
        dispatcher = Dispatcher(session: session)
    }
    
    func searchPhoto(text: String, completion: @escaping (_ photos: PhotosData?, _ error: String?) -> Void){
        dispatcher.performRequest(FlickrRequest.search(perPage: 1, page: 0, text: text).asURLRequest()) { (responseData) in
            let result = HTTPResponseDecoder.decode(responseData: responseData, type: FlickrResponse.self)
            if let photoElement = result.decoded?.data.photoElements.first, let imageURL = photoElement.getURL() {
                if let imageData = try? Data(contentsOf: imageURL) {
                    
                }
            }
        }
    }
}
