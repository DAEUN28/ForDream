//
//  SeachDetailVC.swift
//  ForDream
//
//  Created by baby1234 on 19/03/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchDetailVC: UIViewController {
    
    @IBOutlet weak var closeDetailBtn: UIButton!
    @IBOutlet weak var deleteInDetailBtn: UIButton!
    @IBOutlet weak var writedDateLbl: UILabel!
    @IBOutlet weak var detailTxtView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageIndex: Int!
    var pageCount: Int!
    var pageDream: Dream!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writedDateLbl.text! = pageDream.writedDate
        detailTxtView.text = pageDream.detailTxt
        
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = pageIndex
        pageControl.tintColor = UIColor.init("#A1FA4D")
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.init("#A1FA4D")
    }
    
    @IBAction func selectedCloseDetailBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedDeleteBtnAction(_ sender: Any) {
        let model = Model()
        
        let alert = UIAlertController(title: "삭제", message: "꿈을 지우시겠어요?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default) { (UIAlertAction) in
            DispatchQueue.main.async {
                model.removeAction(removeDream: self.pageDream)
            }
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
