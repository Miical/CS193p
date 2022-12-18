//
//  Diamond.swift
//  SetGame
//
//  Created by Jason Liu on 2022/12/18.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let points = [
            CGPoint(x: rect.width / 2, y: 0),
            CGPoint(x: rect.width, y: rect.height / 2),
            CGPoint(x: rect.width / 2, y: rect.height),
            CGPoint(x: 0, y: rect.height / 2),
        ]
        var path = Path()
        path.move(to: points[3])
        for i in 0..<4 {
            path.addLine(to: points[i])
        }
        return path
    }
}
