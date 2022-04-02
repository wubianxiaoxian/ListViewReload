//
//  EnumDifferViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/30.
//

import UIKit
import DifferenceKit
class EnumDifferViewController: UIViewController {
    var dada: [CellModel] = []
    var dadaInput: [CellModel] {
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
        for i in 0...100 {
            if ((i % 3) == 2) {
                let model = TestModel()
                dadaInput.append(CellModel.testModel(model))
            }  else if ((i % 3) == 1) {
                let model = Stundent()
                dadaInput.append(CellModel.student(model))
            } else {
                let model = User()
                dadaInput.append(CellModel.user(model))
            }
        }
    }
    
    func setupSubViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func generageNewData() {
        let model = TestModel()
        dadaInput = dadaInput.reversed()
    }
    
    @IBAction func testAction(_ sender: Any) {
        print("revert action")
        generageNewData()
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
        dadaInput.insert(CellModel.testModel(model), at: 1)
    }
    
}

extension EnumDifferViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dada.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        let model = dada[indexPath.row]
        if let cell = cell as? TestCell {
            switch model {
            case .testModel(let value):
                cell.cellText.text = "modelType: \(type(of: value))\nrandomStr: \(value.randomStr)"
            case .user(let value):
                cell.cellText.text = "modelType: \(type(of: value))\nrandomStr: \(value.randomStr)"
            case .student(let value):
                cell.cellText.text = "modelType: \(type(of: value))\nrandomStr: \(value.randomStr)"
            }
        }
        print("cellForRowAt indexPath.row\(indexPath.row)")
        return cell
    }

}
