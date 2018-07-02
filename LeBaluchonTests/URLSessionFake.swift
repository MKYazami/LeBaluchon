//
//  URLSessionFake.swift
//  LeBaluchonTests
//
//  Created by Mehdi on 02/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data, response: URLResponse, error: Error) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        
        // Transfer data from FakeResponseData to URLSessionDataTaskFake to be run
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        
        return task
    }

}

class URLSessionDataTaskFake: URLSessionDataTask {
    // Block completion type
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // Declaration of these variables which will contain the values coming from FakeResponseData
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        // Run of completion handler
        completionHandler?(data, urlResponse, responseError)
    }
    
    // This method does not contain anything because there is no network request to cancel it
    override func cancel() {}
}
