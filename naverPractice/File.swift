//
//  File.swift
//  CheckNGoImprovement
//
//  Created by Minwoo Park on 6/18/17.
//  Copyright © 2017 MWdev. All rights reserved.
//


import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
