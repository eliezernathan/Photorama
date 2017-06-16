//
//  PhotoStore.swift
//  phodorama
//
//  Created by eli nathan on 6/8/17.
//  Copyright © 2017 eli nathan. All rights reserved.
//

import UIKit

enum ImageResults {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        
        let url = FlickerAPI.interestingPhotosURL
        // create data request and execute
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
//            if let resp = response as? HTTPURLResponse {
//                let status = resp.statusCode
//                if status == 200 {
//                    let content = String(data: data!, encoding: String.Encoding.ascii)
//                    print(status)
//                }
//            }
            
            let results = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
            completion(results)
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickerAPI.photos(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResults) -> Void) {
        let photoURL = photo.removeURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
            completion(result)
            }
        }
        task.resume()
        
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResults {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
        
        }
    }
    
    
    




