//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()  // remove the name of the program

// Initialize a Calculator object
let calculator = Calculator()

let result = calculator.calculate(args: args)
print(result)
