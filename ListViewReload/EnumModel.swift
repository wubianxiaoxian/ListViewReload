//
//  EnumModel.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/3/30.
//
import DifferenceKit

enum CellModel: Differentiable {
    case testModel(TestModel)
    case user(User)
    case student(Stundent)    
    var differenceIdentifier: UUID {
        switch self {
        case .testModel(let value): return value.uuid
        case .user(let value): return value.uuid
        case .student(let value): return value.uuid
        }
    }
    
    func isContentEqual(to source: CellModel) -> Bool {
        switch (self, source) {
        case let (.testModel(a0), .testModel(a1)): return a0 == a1
        case let (.user(a0), .user(a1)): return a0 == a1
        case let (.student(a0), .student(a1)): return a0 == a1
        default: return false
        }
    }
}


class User: NSObject {
    let uuid = UUID()
    lazy var randomStr: String = {
        return String.randomStr(len: Int.random(in: 1...100))
    }()
    var title: String = "I am a user"
}


class Stundent: NSObject {
    let uuid = UUID()
    lazy var randomStr: String = {
        return String.randomStr(len: Int.random(in: 1...100))
    }()
    var title: String = "I am a Stundent"
}


extension User: Differentiable {
    func isContentEqual(to source: User) -> Bool {
        return self.uuid == source.uuid
    }
    var differenceIdentifier: UUID {
        return self.uuid
    }
}


extension Stundent: Differentiable {
    func isContentEqual(to source: Stundent) -> Bool {
        return self.uuid == source.uuid
    }
    var differenceIdentifier: UUID {
        return self.uuid
    }
}
