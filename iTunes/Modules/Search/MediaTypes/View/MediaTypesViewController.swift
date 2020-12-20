//
//  MediaTypesViewController.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

protocol MediaTypesSelectedDelegate {
    func didSelectMediaTypes(mediaTypes: [String])
}

class MediaTypesViewController: AbstractController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Data
    private let mediaCellIdentifier = "mediaTypeCell"
    public var mediaTypesPresenter = MediaTypesPresenter()
    var mediaTypesSelectedDelegate: MediaTypesSelectedDelegate?
    
    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    // Customize view
    override func customizeView() {
        super.customizeView()
        // Customize title for navigation bar
        self.setNavBarTitle(title: "MEDIA_TYPES_PAGE_TITLE".localized, color: AppColors.black)
        // Show nav bar border
        self.showNavBorder = true
        // Show nav back button
        self.showNavBackButton = true
        // add nav done button
        addDoneButton()
        
        self.view.backgroundColor = AppColors.blueDark
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = AppColors.blueDark
        self.tableView.separatorColor = AppColors.white
        self.tableView.allowsMultipleSelection = true
        
    }

    /// Add done button
    func addDoneButton() {
        // add done nav button
        let done = UIBarButtonItem(title: "DONE".localized, style: .done, target: self, action: #selector(self.doneAction))
        self.navigationItem.rightBarButtonItem = done
    }
    
    @objc private func doneAction() {
        mediaTypesSelectedDelegate?.didSelectMediaTypes(mediaTypes: mediaTypesPresenter.selectedMediaTypes)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: TableView Delegates & Datasource
extension MediaTypesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaTypesPresenter.mediaTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mediaCellIdentifier, for: indexPath) as! MediaTypeCell
        cell.accessibilityIdentifier = "productCell_\(indexPath.row)"
        let mediaType = mediaTypesPresenter.mediaTypes[indexPath.row]
        cell.populateCell(mediaType: mediaType, isSelected: mediaTypesPresenter.isSelected(mediaType: mediaType))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mediaTypesPresenter.selectDeselectMediaType(mediaType: mediaTypesPresenter.mediaTypes[indexPath.row])
        tableView.reloadData()
    }
    
}
