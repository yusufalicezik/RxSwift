//
//  ValidateSecondViewController.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 14.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ValidateSecondViewController: UIViewController {

    var comingVC:UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        (comingVC as? ValidateViewController)?.subject.subscribe({ user in
            print(user.element?.eMail)
            })
        // Do any additional setup after loading the view.
    }
    

}
