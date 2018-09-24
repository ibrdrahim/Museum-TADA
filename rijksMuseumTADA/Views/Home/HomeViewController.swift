//
//  HomeViewController.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import SDWebImage

class HomeViewController: SideMenuViewController, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var museumCollectionView: UICollectionView!
    
    let viewModel = MuseumViewModel.sharedInstance
    let disposeBag = DisposeBag()
    
    let museumCellViewReusableId = "MuseumCollectionViewCell"
    
    var nextOffset: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        let cell = UINib(nibName: "MuseumCollectionViewCell", bundle: nil)
        museumCollectionView.register(cell, forCellWithReuseIdentifier: "MuseumCollectionViewCell")
        self.viewModel.refreshInitialMuseumData()
        self.viewModel.museumsObservable.bind(to: self.museumCollectionView.rx.items) { [unowned self] cv, row, el in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.museumCellViewReusableId, for: indexPath) as! MuseumCollectionViewCell
            cell.museum = el
            cell.museumImage.sd_setImage(with: URL(string: el.headerUrl), placeholderImage: #imageLiteral(resourceName: "placeholder3"))
            cell.museumTitle.text = el.title
            
            return cell
            }
            .disposed(by: disposeBag)
        
        self.museumCollectionView.rx.didEndDragging
            .subscribe(onNext: { [unowned self] _ in
                if (self.museumCollectionView.contentOffset.y >= (self.museumCollectionView.contentSize.height - self.museumCollectionView.frame.size.height)) {
                    //reach bottom
                    self.viewModel.refreshMuseumDataInfinity()
                }
            })
            .disposed(by: disposeBag)
        self.museumCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let cell = self.museumCollectionView.cellForItem(at: indexPath) as? MuseumCollectionViewCell
                self.performSegue(withIdentifier: "detail", sender: cell?.museum)
            }).disposed(by: disposeBag)
        self.museumCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width
        
        return CGSize(width: width - 20, height: 160.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let dc = segue.destination as! DetailViewController
            let museum = sender as? MuseumViewModel.MuseumCollectionViewCellData
            dc.imageUrl = museum?.imageUrl
            dc.museumDesc = museum?.longTitle
        }
    }

}
