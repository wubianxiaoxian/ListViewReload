//
//  TestModel.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/29.
//

import UIKit
import DifferenceKit
class TestModel: NSObject {
    let uuid = UUID()
    lazy var randomStr: String = {
        let Emojis = (0x1F600...0x1F647).compactMap { UnicodeScalar($0).map(String.init) }
        let splitedCount = Int.random(in: 1...20)
        let start = Int.random(in: 1...20)
        let end = min(start + splitedCount, Emojis.endIndex)
        return "\(Emojis[start..<end])" + String.randomStr(len: Int.random(in: 1...100))
    }()
    var des: String = "this is TestModel"
}



extension TestModel: Differentiable {
    func isContentEqual(to source: TestModel) -> Bool {
        return self.uuid == source.uuid
    }
    var differenceIdentifier: UUID {
        return self.uuid
    }
}

extension String{
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}

