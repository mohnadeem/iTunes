//
//  ServiceManager.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import Foundation
import Alamofire


/// - Api store do all Networking stuff
///     - build server request
///     - prepare params
///     - and add requests headers
///     - parse Json response to App data models
///     - parse error code to Server error object
///
class ServiceManager: NSObject {
    
    // MARK: Data
    let baseURL = "\(AppConfig.appBaseURL)/"
    
    // MARK: Shared Instance
    static let shared: ServiceManager = ServiceManager()
    
    private override init(){
          super.init()
      }
    
    /**
    make api request and return request
     - parameter url: request url
     - parameter method: http method of request eg: get, post
     - parameter parameters: body parameters
     - parameter completionHandler: closure to return back the success or failure result
     - parameter responseObject: any data response
     - parameter jsonResponse: JSON response object
     - parameter error: error back from server
     */
    func makeRequest(url: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, completionHandler: @escaping (_ responseData: Data?, _ error: Error?) -> Void) -> DataRequest {
        let requestURL = baseURL +  url
        let request = AF.request(requestURL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: []).responseData { (responseObject) in
            switch responseObject.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        return request
    }
    
    func loadMockJson() -> Data? {
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
        }
        return nil
    }
}
