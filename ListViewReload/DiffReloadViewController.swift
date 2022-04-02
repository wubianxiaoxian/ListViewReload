//
//  DiffReloadViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/29.
//

import UIKit
import DifferenceKit
class DiffReloadViewController: UIViewController {
    var dada: [TestModel] = []
    var dadaInput: [TestModel] {
        get {
            return dada
        }
        set {
            let changeset = StagedChangeset(source: self.dada, target: newValue)
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
            let model = TestModel()
            model.des = "this is \(i) model"
            dadaInput.append(model)
        }
    }
    
    func setupSubViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func testAction(_ sender: Any) {
        print("testAction")
        generageNewData()
//        tableView.reloadData()
    }
    
    func generageNewData() {
        dadaInput = dada.reversed()
    }
}

extension DiffReloadViewController: UITableViewDelegate, UITableViewDataSource {
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
            cell.cellText.text = "\(model.des)"
        }
        print("cellForRowAt indexPath.row\(indexPath.row)")
        return cell
    }

}
