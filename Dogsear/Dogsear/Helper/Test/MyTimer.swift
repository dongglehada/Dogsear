//
//  TestManager.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/13/23.
//

import Foundation

class MyTimer {
    var timer: Timer?
    var seconds: Double = 0

        init() {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        }

        @objc func timerFired() {
            seconds += 0.01
        }

        func stopTimer() {
            print("@@@",seconds)
            timer?.invalidate()
            timer = nil
        }
}
