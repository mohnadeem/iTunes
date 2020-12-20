//
//  SearchRouter.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

class SearchRouter {
    
    /// show media types search categories
    func showMediaTypesView(delegate: MediaTypesSelectedDelegate, mediaTypes: [String]) {
        let mediaTypesVC = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MediaTypesViewController") as! MediaTypesViewController
        mediaTypesVC.mediaTypesSelectedDelegate = delegate
        if mediaTypes.count > 0 {
            mediaTypesVC.mediaTypesPresenter.selectedMediaTypes = mediaTypes
        }
        UIApplication.visibleNavigationController()?.pushViewController(mediaTypesVC, animated: true)
    }
    
    /// Show search results screen
    func showSearchResultsView(item: Item) {
        let searchResultsVC = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        searchResultsVC.searchResultPresenter.items = item.results
        UIApplication.visibleNavigationController()?.pushViewController(searchResultsVC, animated: true)
    }
    
    /// Show alert screen
    public func showAlert(style: CustomAlertStyle, delegate: CustomAlertViewDelegate? = nil, title: String = "", message: String = "", actionTitle: String = "", completionBlock:(@escaping()->()) = {})   {
        let alertViewController = UIStoryboard.alertStoryboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        alertViewController.setData(style: style, delegate: delegate, title: title, message: message, actionTitle: actionTitle)
        
        alertViewController.modalPresentationStyle = .overFullScreen
        if let visibleController = UIApplication.visibleViewController() {
            if !visibleController.isBeingPresented {
                visibleController.present(alertViewController, animated: true, completion: {
                    completionBlock()
                })
            }
        }
    }
}
