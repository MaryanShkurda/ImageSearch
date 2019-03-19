//
//  FlickrManager.swift
//  ImageSearch
//
//  Created by Marian on 3/19/19.
//  Copyright © 2019 Marian. All rights reserved.
//

import Foundation
import RealmSwift

private extension String {
    static let noImageMessage = NSLocalizedString("No image found", comment: "No image found message")
}

class FlickrManager {
    
    private let dispatcher: Dispatcher
    private let persistanceManager: PersistenceManager
    
    init(session: URLSession = URLSession.shared) {
        dispatcher = Dispatcher(session: session)
        persistanceManager = PersistenceManager.instance
    }
    
    func searchPhoto(text: String, completion: @escaping (_ error: String?) -> Void){
        dispatcher.performRequest(FlickrRequest.search(perPage: 1, page: 0, text: text).asURLRequest()) {
            [weak self] (responseData) in
            let result = HTTPResponseDecoder.decode(responseData: responseData, type: FlickrResponse.self)
            if let error = result.errorMessage {
                completion(error)
                return
            }
            guard let photoElement = result.decoded?.data.photoElements.first,
                let imageURL = photoElement.getURL()
                else {
                    completion("\(String.noImageMessage) for \(text)")
                    return
            }
            
            var imageData: Data!
            do {
                imageData = try Data(contentsOf: imageURL)
            }catch let error {
                completion(error.localizedDescription)
                return
            }
            self?.persistanceManager.save(photoData: imageData, forKeyword: text)
            completion(nil)
        }
    }
}
