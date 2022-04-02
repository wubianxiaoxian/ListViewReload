//
//  DiffAutoViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/29.
//

import UIKit
import DifferenceKit
class DiffAutoHeightViewController: UIViewController {
    var dada: [TestModel] = []
    var dadaInput: [TestModel] {
        get {
            return dada
        }
        set {
            let changeset = StagedChangeset(source: self.dada, target: newValue)
            print("changeset \(changeset)")
            self.tableView.reload(using: changeset, with: .automatic) { data in
                self.dada = data
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        for _ in 0...30 {
            let model = TestModel()
            dadaInput.append(model)
        }
    }
    
    func setupSubViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func testAction(_ sender: Any) {
        print("revert action")
        generageNewData()
    }
    
    @IBAction func moveAction(_ sender: Any) {
        exchangeValue(&dadaInput, 0, 2)
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
        dadaInput.insert(model, at: 0)
    }
    
    func generageNewData() {
        dadaInput = dadaInput.reversed()
    }
}

extension DiffAutoHeightViewController: UITableViewDelegate, UITableViewDataSource {
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
