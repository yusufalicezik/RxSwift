//
//  TakListViewController.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 13.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskViewController else {
                fatalError("controller not found")
        }
        addTVC.taskSubjectObservable.subscribe(onNext: {[unowned self] task in
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex-1)
            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: priority)
        }).disposed(by: disposeBag)
    }
    
    private func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTasks(by priority:Priority?){
        if priority == nil{
            self.filteredTasks = self.tasks.value // All
            self.updateTableView()
        }else{
            self.tasks.map{ tasks in
                return tasks.filter{ $0.priority == priority!}
                }.subscribe(onNext:{[weak self] tasks in
                    self?.filteredTasks = tasks
                    self!.updateTableView()
                }).disposed(by: disposeBag)
        }
        
    }

    @IBAction func priorityValueChanged(_ sender: Any) {
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex-1)
        filterTasks(by: priority)
    }
    
}
extension TaskListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    
}
