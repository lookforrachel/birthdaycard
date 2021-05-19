//
//  Constants.swift
//  HappyBirthday
//
//  Created by Joss Manger on 5/19/21.
//  Copyright © 2021 Lookforrachel. All rights reserved.
//

import Foundation

struct AudioPath {
  let name: String
  let type: String
  
  var url: URL? {
    return Bundle.main.url(forResource: self.name, withExtension: self.type)
  }
  
}

struct Constants {
  static let birds = AudioPath(name: "Birds_01", type: "aif")
  static let party = AudioPath(name: "Who Likes to Party", type: "mp3")
}
