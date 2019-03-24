//
//  SearchVC.swift
//  ForDream
//
//  Created by baby1234 on 15/02/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let model = Model()
    
    var dreamContainers = DreamContainer.sharedInstance
    var filterdDream: [Dream]!
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var datailTxtsearchBar: UISearchBar!
    @IBOutlet weak var alignOptionBtn: UIButton!
    @IBOutlet weak var dateOptionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterdDream = dreamContainers.dreamContainers
        
        DispatchQueue.main.async {
            self.model.fetchContainers(loadingIsFinished: {
                self.filterdDream = self.dreamContainers.dreamContainers
                self.searchTableView.reloadData()
            })
        }
        
        
        if #available(iOS 10.0, *) {
            searchTableView.refreshControl = refreshControl
        } else {
            searchTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        dreamContainers.dreamContainers.removeAll()
        DispatchQueue.main.async {
            self.model.fetchContainers {
                self.searchTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func searchDream(_ searchText: String) -> [Dream] {
        let filtered = dreamContainers.dreamContainers.filter { (Dream) -> Bool in
            if self.dateOptionBtn.currentTitle == "날짜" {
                if Dream.detailTxt.range(of: searchText, options: .caseInsensitive) != nil{
                    return true
                } else {
                    return false
                }
            } else {
                if Dream.writedDate.range(of: self.dateOptionBtn.currentTitle!, options: .caseInsensitive) != nil{
                    return true
                } else {
                    return false
                }
            }
        }
        
        return filtered
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterdDream = dreamContainers.dreamContainers
        } else {
            let searchedDream = searchDream(searchText)
            
            switch alignOptionBtn.currentTitle {
            case "정렬":
                filterdDream = searchedDream
            case "오름차순":
                filterdDream = model.ascendingOrder(dream: searchedDream)
            case "내림차순":
                filterdDream = model.descendingOrder(dream: searchedDream)
            default :
                print(Error.self)
            }
        }
        
        searchTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdDream.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dreamCell = searchTableView.dequeueReusableCell(withIdentifier: "SearchDreamCell") as! SearchDreamCell
        
        dreamCell.writedDateLbl.text! = filterdDream[indexPath.row].writedDate
        
        return dreamCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = searchTableView.indexPathForSelectedRow?.row else {
            print(Error.self)
            return
        }
        
        if segue.identifier == "searchCellToDetail"{
            (segue.destination as! SearchDetailPVC).currentDream = filterdDream[row]
            (segue.destination as! SearchDetailPVC).currentIndex = row
            (segue.destination as! SearchDetailPVC).filterdDream = filterdDream
        }
    }

    @IBAction func moveToMainBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func alignOptionBtnAction(_ sender: UIButton) {
        StringPickerPopover(title: "정렬", choices: ["오름차순","내림차순"])
            .setSelectedRow(0)
            .setDoneButton(action: { _, _, selectedString in
                self.alignOptionBtn.setTitle(selectedString, for: UIControl.State.normal)
            })
            .setCancelButton(action: { _, _, _ in
                self.alignOptionBtn.setTitle("정렬", for: UIControl.State.normal)
            })
            .appear(originView: sender, baseViewController: self)
    }
    
    @IBAction func dateOptionBtnAction(_ sender: UIButton) {
        var dateContainer: String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        _ = DatePickerPopover(title: "꿈꾼 날짜")
            .setDateMode(.date)
            .setSelectedDate(Date())
            .setDoneButton(action: { _, selectedDate in
                dateContainer = dateFormatter.string(from: selectedDate as Date)
                if let tmp = dateContainer {
                    self.dateOptionBtn.setTitle(tmp, for: UIControl.State.normal)
                }})
            .setCancelButton(action: { _, _ in
                self.dateOptionBtn.setTitle("날짜", for: UIControl.State.normal)
            })
            .appear(originView: sender, baseViewController: self)
    }
}
