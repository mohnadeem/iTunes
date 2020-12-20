//
//  SearchResultViewController.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 18/12/2020.
//

import UIKit

class SearchResultViewController: AbstractController {

    // MARK: Properties
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listLaout: UIView!
    @IBOutlet weak var gridLayout: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Data
    private let itemCollectionCellIdentifier = "itemCollectionViewCell"
    private let itemTableCellIdentifier = "itemTableViewCell"
    private let itemTableCellHight: CGFloat = 100
    public var searchResultPresenter = SearchResultPresenter()

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
        // Show nav bar border
        self.showNavBorder = false
        // Show nav back button
        self.showNavBackButton = true
        // set nav logo
        self.setNavBarLogo(logo: #imageLiteral(resourceName: "Image"))
        
        listButton.backgroundColor = AppColors.blueDark
        gridButton.backgroundColor = AppColors.blueDark
    
        // hides list layout and show grid layout initially
        gridLayout.isHidden = false
        listLaout.isHidden = true
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func gridAction(_ sender: Any) {
        gridLayout.isHidden = false
        listLaout.isHidden = true
    }
    
    @IBAction func listAction(_ sender: Any) {
        listLaout.isHidden = false
        gridLayout.isHidden = true
    }
}

// MARK: TableView Delegates & Datasource
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemTableCellHight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultPresenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemTableCellIdentifier, for: indexPath) as! ItemTableViewCell
        let result = searchResultPresenter.items[indexPath.row]
        cell.populateCell(result: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: CollectionView Delegates & Datasource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultPresenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCollectionCellIdentifier, for: indexPath) as! ItemCollectionViewCell
        let result = searchResultPresenter.items[indexPath.row]
        cell.populateCell(result: result)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 3
      return CGSize(width: itemSize, height: itemSize)
    }
  }

// MARK: CollectionView Delegates & Datasource
extension SearchResultViewController: CustomCollectionLayoutDelegate {
    func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemCollectionViewCell
        return cell.itemView.itemImage.image?.size.height ?? 200
    }
}
