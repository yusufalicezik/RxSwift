//
//  ValidateViewController.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 14.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct User{
    var eMail,eMailAgain:String
}
class ValidateViewController: UIViewController {

    var disposeBag = DisposeBag()
    private var mSubject = PublishSubject<User>()
    var subject:Observable<User>{
        return mSubject.asObservable()
    }
    @IBOutlet weak var eMailTxtField: UITextField!
    @IBOutlet weak var eMailAgainTxtField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSub()

    }
    func setupSub(){
        let eMailObs:Observable<String?> = eMailTxtField.rx.text.asObservable()
        let eMailAgainObs:Observable<String?> = eMailAgainTxtField.rx.text.asObservable()

        let mailObservable:Observable<Bool> = Observable.combineLatest(eMailObs, eMailAgainObs) { (eMail:String?, eMail2:String?) in
            eMail2 == eMail && eMail2!.count > 6
        }
        
        mailObservable.bind(to: messageLabel.rx.isHidden).disposed(by: disposeBag)
        
      
    }
 
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? ValidateSecondViewController
        vc?.comingVC = self
        self.present(vc!, animated: true) {
            self.mSubject.onNext(User(eMail: self.eMailTxtField.text!, eMailAgain: self.eMailTxtField.text!))//same, just for using struct
        }
    }
}
