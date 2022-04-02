//
//  TestCell.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/29.
//

import UIKit

class TestCell: UITableViewCell {
    @IBOutlet weak var cellText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
