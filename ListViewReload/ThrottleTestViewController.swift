//
//  ThrottleTestViewController.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/4/2.
//

import UIKit

class ThrottleTestViewController: UIViewController {
    let throttle = Throttle(label: "123", interval: 500)
    
    let debouncer = Debouncer(label: "123", interval: 500)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func testThrottle() {
        for _ in 0..<10 {
            throttle.call {
                let date = Date()
                print("testThrottle: \(date.timeIntervalSince1970)")
            }
        }
    }
    
    func testDebouncer() {
        for i in 0..<100 {
            let delay = i % 2 == 0 ? 1 : 3
            sleep(UInt32(delay))
            debouncer.call {
                let date = Date()
                print("testDebouncer: \(date.timeIntervalSince1970)")
            }
        }
    }
}
