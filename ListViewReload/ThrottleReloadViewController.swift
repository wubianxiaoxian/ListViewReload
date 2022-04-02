//
//  ThrottleReloadViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/30.
//

import UIKit
import RxCocoa
import DifferenceKit
import RxSwift
class ThrottleReloadViewController: UIViewController {
    var disposeBag = DisposeBag()
    var receiveData: PublishSubject<[TestModel]> = PublishSubject<[TestModel]>()
    var dada: [TestModel] = []
    var isOpenThrottle: Bool = true
    var dadaInput: [TestModel] {
        get {
            return dada
        }
        set {
            let changeset = StagedChangeset(source: self.dada, target: newValue)
            self.tableView.reload(using: changeset, with: .automatic) { data in
                print("ThrottleReloadVC dadaInput --> Reload")
                self.dada = data
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        dadaInput = generateData(30)
        addObserver()
    }
    
    func addObserver() {
        if isOpenThrottle {
           receiveData
                .throttle(.seconds(1), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] value in
                    guard let self = self else { return }
                    self.dadaInput = value
            }).disposed(by: disposeBag)
        } else {
            receiveData.subscribe(onNext: { [weak self] value in
                     guard let self = self else { return }
                     self.dadaInput = value
             }).disposed(by: disposeBag)
        }
     }
    
    func setupSubViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func generateData(_ count: Int) -> [TestModel] {
        var data: [TestModel] = []
        for i in 0...count {
            let model = TestModel()
            data.append(model)
        }
        return data
    }
    
    @IBAction func openThrottleAction(_ sender: Any) {
        isOpenThrottle = true
        disposeBag = DisposeBag()
        addObserver()
        for i in 0...1000 {
            receiveData.onNext(generateData(30))
        }
    }
    
    @IBAction func withOutrottleAction(_ sender: Any) {
        isOpenThrottle = false
        disposeBag = DisposeBag()
        addObserver()
        for i in 0...1000 {
            receiveData.onNext(generateData(30))
        }
    }
    
    @IBAction func moveAction(_ sender: Any) {
        exchangeValue(&dadaInput, 0, 3)
        print("moveAction")
    }
    
    func exchangeValue<T>(_ nums: inout [T], _ a: Int, _ b: Int) {
        (nums[a], nums[b]) = (nums[b], nums[a])
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        print("deleteAction")
        dadaInput.remove(at: 2)
    }
    
    
    @IBAction func insertction(_ sender: Any) {
        let model = TestModel()
        dadaInput.insert(model, at: 1)
    }
    
    func generageNewData() {
        dadaInput = dadaInput.reversed()
    }
}

extension ThrottleReloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dada.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        let model = dada[indexPath.row]
        if let cell = cell as? TestCell {
            cell.cellText.text = "indexPath row: \(indexPath.row) \nrandomStr: \(model.randomStr)"
        }
        print("cellForRowAt indexPath.row\(indexPath.row)")
        return cell
    }
}
