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
            self?.photoImageView.image = photo
        }).disposed(by: disposeBg)

    }


}

