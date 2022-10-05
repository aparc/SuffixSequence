//
//  JobScheduler.swift
//  SuffixSequence
//
//  Created by Андрей Парчуков on 05.10.2022.
//

import Foundation

class JobScheduler {
    
    static let shared = JobScheduler()
    
    private lazy var jobQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        
        return queue
    }()
    
    private init() {}
    
    func execute(_ jobs: [Job], completion: ([SuffixOccurrence]) -> Void) {
        jobQueue.addOperations(jobs, waitUntilFinished: true)
        
        let result = jobs.map { job in
            SuffixOccurrence(
                suffix: job.substring,
                occurrenceCount: job.suffixOccurrenceCount ?? 0,
                searchExecutionTime: job.executionTime ?? 0.0
            )
        }
        
        completion(result)
    }
    
}
