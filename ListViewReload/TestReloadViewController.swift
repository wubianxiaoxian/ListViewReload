//
//  TestReloadViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/29.
//

import UIKit

class TestReloadViewController: UIViewController {
    var dada: [TestModel] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        setupSubViews()
        for i in 0...100 {
            let model = TestModel()
            model.des = "this is \(i) model"
            dada.append(model)
        }
    }
    
    func setupSubViews() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(UINib.init(nibName: "TestCell", bundle: Bundle?), forCellReuseIdentifier: "TestCell")
    }
    @IBAction func testAction(_ sender: Any) {
        print("testAction")
        generageNewData()
        tableView.reloadData()
    }
    
    func generageNewData() {
        dada = dada.reversed()
    }
}

extension TestReloadViewController: UITableViewDelegate, UITableViewDataSource {
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
 
