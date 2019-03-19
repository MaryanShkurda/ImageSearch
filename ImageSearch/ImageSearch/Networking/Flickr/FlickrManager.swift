//
//  FlickrManager.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation

private extension String {
    static let noImageMessage = NSLocalizedString("No image found", comment: "No image found message")
}

class FlickrManager {
    
    private let dispatcher: Dispatcher
    
    init(session: URLSession = URLSession.shared) {
        dispatcher = Dispatcher(session: session)
    }
    
    func searchPhoto(text: String, completion: @escaping (_ photo: Photo?, _ error: String?) -> Void){
        dispatcher.performRequest(FlickrRequest.search(perPage: 1, page: 0, text: text).asURLRequest()) { (responseData) in
            let result = HTTPResponseDecoder.decode(responseData: responseData, type: FlickrResponse.self)
            if let error = result.errorMessage {
                completion(nil, error)
                return
            }
            guard let photoElement = result.decoded?.data.photoElements.first,
                let imageURL = photoElement.getURL()
                else {
                    completion(nil, "\(String.noImageMessage) for \(text)")
                    return
            }
            
            var imageData: Data?
            do {
                imageData = try Data(contentsOf: imageURL)
            }catch let error {
                completion(nil, error.localizedDescription)
                return
            }
            
            let photo = Photo()
            photo.keyword = text
            photo.data = imageData
            completion(photo, nil)
        }
    }
}
