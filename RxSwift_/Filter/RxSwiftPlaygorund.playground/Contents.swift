import UIKit
import RxSwift
//
//let observable = Observable.just(1)
//
//let observable2 = Observable.of(1,2,3)
//
//let observable4 = Observable.from([1,2,3])
//
//let substriction4 = observable4.subscribe(onNext:{ element in
//    print(element)
//})
//substriction4.dispose()

//let disposeBag = DisposeBag()

//Observable.of("A","B","C")
//    .subscribe{
//        print($0)
//}.disposed(by: disposeBag)
//
//Observable<String>.create{ observer in
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("complts")}, onDisposed: {print("disposed")})
//.disposed(by: disposeBag)

let disposeBag = DisposeBag()
let subject = PublishSubject<String>()
subject.onNext("issue 1")

subject.subscribe{ event in
    print(event)
}.disposed(by: disposeBag)
subject.onNext("Issue 2")
subject.onNext("Issue 3")
subject.onCompleted()

