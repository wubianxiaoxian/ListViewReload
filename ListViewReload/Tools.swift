//
//  Debouncer.swift
//  ListViewReload
//
//  Created by Kent Sun on 2022/4/2.
//

import UIKit

class Debouncer {
    private let label: String
    private let interval: Int
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    private var lock: DispatchSemaphoreWrapper
    
    /// interval: 单位毫秒
    init(label: String = "Debouncer", interval: Int = 500) {
        self.label = label
        self.interval = interval
        self.queue = DispatchQueue(label: label)
        self.lock = DispatchSemaphoreWrapper(value: 1)
    }
    
    func call(_ callback: @escaping (() -> ())) {
        self.lock.sync {
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem {
                callback()
            }
            
            if let workItem = self.workItem {
                self.queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(interval), execute: workItem)
            }
        }
    }
}

struct DispatchSemaphoreWrapper {
    private var lock: DispatchSemaphore
    init(value: Int) {
        self.lock = DispatchSemaphore(value: 1)
    }
    
    func sync(execute: () -> ()) {
        _ = lock.wait(timeout: DispatchTime.distantFuture)
        lock.signal()
        execute()
    }
}

class Throttle {
    private let label: String
    private let interval: Int
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    private var lock: DispatchSemaphoreWrapper
    private var lastTime: Date = Date()
    
    /// interval: 单位毫秒
    init(label: String = "Throttle", interval: Int = 500) {
        self.label = label
        self.interval = interval
        self.queue = DispatchQueue(label: label)
        self.lock = DispatchSemaphoreWrapper(value: 1)
    }
    
    func call(_ callback: @escaping (() -> ())) {
        self.lock.sync {
            print("sss sync")
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem { [weak self] in
                self?.lastTime = Date()
                print("sss  self?.lastTime = Date()")
                callback()
            }
            if let workItem = self.workItem {
                let new = Date()
                let delay = new.timeIntervalSince1970 - lastTime.timeIntervalSince1970 > Double(self.interval)/1000 ? DispatchTimeInterval.milliseconds(0) : DispatchTimeInterval.milliseconds(self.interval)
                self.queue.asyncAfter(deadline: .now() + delay, execute: workItem)
            }
        }
    }
}

