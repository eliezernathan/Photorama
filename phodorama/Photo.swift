//
//  Photo.swift
//  phodorama
//
//  Created by eli nathan on 6/8/17.
//  Copyright © 2017 eli nathan. All rights reserved.
//

import Foundation


class Photo {
    
    let title: String
    let removeURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String, removeURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.removeURL = removeURL
        self.dateTaken = dateTaken
     }
 }
