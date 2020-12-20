//
//  SearchInteractor.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import Foundation

class SearchInteractor {
    
    /**
     Get list of search items
     - parameter term: the search term
     - parameter mediaType: the search category
     - parameter completionBlock: closure to return back the success or failure result
     - parameter success: the process finished successfully
     - parameter error: error back from server
     */
    func search(term: String, mediaType: String, _ completionHandler: @escaping (_ item: Item?, _ error: Error?) -> Void) {
        let urlString = "search?term=\(term)&entity=\(mediaType)"
        let requestURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        _ = ServiceManager.shared.makeRequest(url: requestURL) { (responseData, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {// success case
                guard let data = responseData else {
                    completionHandler(nil, error)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Item.self, from: data)
                    completionHandler(result, nil)
                }catch {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
