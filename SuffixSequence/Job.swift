//
//   Job.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 03.10.2022.
//

import Foundation

class Job: Operation {
    
    private let lockQueue = DispatchQueue(label: "lockQueue", attributes: .concurrent)
    
    let substring: String
    var suffixOccurrenceCount: Int?
    var executionTime: CFAbsoluteTime?
    
    private let text: String
    private let suffixArray: [Int]
    private var startExecutionTime: CFAbsoluteTime?
    
    private var _isExecuting: Bool = false
    private var _isFinished: Bool = false
    
    init(text: String, suffixArray: [Int], substring: String) {
        self.text = text
        self.suffixArray = suffixArray
        self.substring = substring
    }
    
    private func finish() {
        isExecuting = false
        isFinished = true
        if let startExecutionTime = startExecutionTime {
            executionTime = CFAbsoluteTimeGetCurrent() - startExecutionTime
        }
    }
    
    private func search(substring: String) -> (Int, Int) {
        var l = 0
        var r = text.count
        
        while l < r {
            let mid = (l + r) / 2
            
            let fromIndex = text.index(text.startIndex, offsetBy: suffixArray[mid])
            let part = text[fromIndex...]
            if substring > part {
                l = mid + 1
            } else {
                r = mid
            }
        }
        
        let s = l
        r = text.count
        
        while l < r {
            let mid = (l + r) / 2
            let fromIndex = text.index(text.startIndex, offsetBy: suffixArray[mid])
            let part = text[fromIndex...]
            
            if part.starts(with: substring) {
                l = mid + 1
            } else {
                r = mid
            }
        }
        
        return (s, r)
    }
    
}

// MARK: - Inherited Properties And Methods
extension Job {
    
    override var isAsynchronous: Bool { true }
    
    override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override func start() {
        startExecutionTime = CFAbsoluteTimeGetCurrent()
        isFinished = false
        isExecuting = true
        main()
    }
    
    override func main() {
        let founded = search(substring: substring)
        suffixOccurrenceCount = founded.1 - founded.0
        self.finish()
    }

}
