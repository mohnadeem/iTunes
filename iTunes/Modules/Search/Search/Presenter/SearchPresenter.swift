//
//  SearchPresenter.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import Foundation

class SearchPresenter {
    
    // MARK: Data
    var searchRouter = SearchRouter()
    var searchInteractor = SearchInteractor()
    var selectedMediaTypes: [String] = []

    /// select media types
    func selectMediaTypes(delegate: MediaTypesSelectedDelegate, mediaTypes: [String]) {
        searchRouter.showMediaTypesView(delegate: delegate, mediaTypes: mediaTypes)
    }

    /// get search results
    func getSearchResults(term: String, _ completion: @escaping ((_ data: Item?, _ error: Error?)->Void)) {
        if selectedMediaTypes.count > 0 {
            for type in selectedMediaTypes {
                searchInteractor.search(term: term, mediaType: type) { (item, error) in
                    if let err = error {
                        completion(nil, err)
                    }else {
                        completion(item, nil)
                    }
                }
            }
        }else {
            searchInteractor.search(term: term, mediaType: "") { (item, error) in
                if let err = error {
                    completion(nil, err)
                }else {
                    completion(item, nil)
                }
            }
        }
    }
    
    /// show alert
    func  showAlert(message: String) {
        self.searchRouter.showAlert(style: .oneActionAlert, title: "ERROR".localized, message: message, actionTitle: "OK".localized)
    }
    
    /// Validate search text field
    func isValidSearchTerm(term: String?) -> Bool {
        if term != nil && term != "" {
            return true
        }else {
            return false
        }
    }
}
