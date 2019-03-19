//
//  Photo.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/19/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Photo: Object {
    dynamic var keyword = ""
    dynamic var data: Data?
}
