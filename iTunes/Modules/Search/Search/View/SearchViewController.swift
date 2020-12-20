//
//  SearchViewController.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

class SearchViewController: AbstractController {

    // MARK: Properties
    @IBOutlet weak var entitiesView: TagListView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var submitButton: TransitionButton!

    // MARK: Data
    var searchPresenter = SearchPresenter()

    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // Customize view
    override func customizeView() {
        super.customizeView()
        
        // media types selection
        entitiesView.superview?.tapAction { [unowned self] in
            searchPresenter.selectMediaTypes(delegate: self, mediaTypes: searchPresenter.selectedMediaTypes)
        }
    }
    
    // MARK: Functions
    /// add media types
    func addMediaTypes() {
        entitiesView.removeAllTags()
        for type in searchPresenter.selectedMediaTypes {
            entitiesView.addTag(type)
        }
    }
    
    // MARK: Actions
    /// submit action
    @IBAction func submitAction(_ sender: UIButton) {
        if searchPresenter.isValidSearchTerm(term: searchTextField.text) {
            self.submitButton.startAnimation()
            searchPresenter.getSearchResults(term: searchTextField.text ?? "") { (data, error) in
                if let model = data {
                    self.submitButton.stopAnimation()
                    self.searchPresenter.searchRouter.showSearchResultsView(item: model)
                }else {
                    self.submitButton.stopAnimation(animationStyle: .shake) {
                        self.searchPresenter.showAlert(message: error?.localizedDescription ?? "")
                    }
                }
            }
        }else {
            self.searchPresenter.showAlert(message: "SEARCH_VALIDATION_MSG".localized)
        }
    }
}

// MARK: MediaTypes Selected delegate
extension SearchViewController: MediaTypesSelectedDelegate {
    func didSelectMediaTypes(mediaTypes: [String]) {
        searchPresenter.selectedMediaTypes = mediaTypes
        addMediaTypes()
    }
}
