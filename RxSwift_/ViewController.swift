//
//  ViewController.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 13.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {

    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    let disposeBg = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosVC = navC.viewControllers.first as? PhotosCollectionViewController else {return}
        photosVC.selectedPhoto.subscribe(onNext: {[weak self] (photo) in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBg)

    }

    private func updateUI(with image: UIImage){
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    @IBAction func applyFilterPressed(){
        guard let sourceImage = self.photoImageView.image else {return}
//        FilterService().applyFilter(to: sourceImage) { (image) in
//            DispatchQueue.main.async {
//                self.photoImageView.image = image
//            }
//        }
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext:{ filteredImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
            }).disposed(by: disposeBg)
    }

}

