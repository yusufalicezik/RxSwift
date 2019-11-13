//
//  AddTaskViewController.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 13.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable : Observable<Task>{
        return taskSubject.asObservable()
    }
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(){
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
            let title = self.taskTitleTextField.text else {
                return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }

}
