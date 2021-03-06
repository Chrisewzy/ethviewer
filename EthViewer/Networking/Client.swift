//
//  Client.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation
import UIKit

typealias ClientCallback =  (Data?, URLResponse?, Error?) -> ()

protocol RequestClient {
  func perform(request: URLRequest, callback: @escaping ClientCallback)
}

class SessionClient: RequestClient {
  
  private let session: URLSession
  
  init() {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30;
    config.timeoutIntervalForResource = 30;
    config.urlCache = URLCache.shared
    session = URLSession(configuration: config)
  }
  
  func perform(request: URLRequest, callback: @escaping ClientCallback) {
    let task = session.dataTask(with: request) { data, res, err in
      DispatchQueue.main.async {
        callback(data, res, err)
      }
    }
    
    task.resume()
    
  }
}
