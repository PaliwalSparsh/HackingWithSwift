//: [Previous](@previous)

import Foundation
import CoreGraphics

let p1 = CGPoint(x: 0, y: 0)
let p2 = CGPoint(x: -1, y: -1)

//print((atan2(-1.0, -1.0) * 180.0 / .pi))
//func calculateDistanceAndAngle(p1: CGPoint, p2:CGPoint) -> (distance: CGFloat, angle: Angle) {
//    let height = p2.y - p1.y
//    let base = p2.x - p1.x
//    let angle = atan2(height, base)
//    let distance = sqrt(pow(height,2) + pow(base,2))
//    return (distance, angle)
//}


func getDistanceAndDirection(_ pt1: CGPoint, _ pt2: CGPoint) -> (distance: CGFloat, angle: CGFloat) {
    let a = pt2.y - pt1.y // calculate leg a
    let b = pt2.x - pt1.x // calculate leg b
    
    // pythogorus
    let h = sqrt(pow(a,2) + pow(b,2))
     
    // atan2 gives angles between for 0 to 180 -> 0 to pi and 180 to 360 -> -pi to 0. So we have to add 2*pi to it to make things positive.
    // atan is essentially tan^-1, atan(tan 0) = 0, zero ko theta maanlo. Par atan ki value -pi/2 se pi/2 hoti hai toh direction ki information loose ho jaati hai, so we use atan2, which is mostly used in computer graphics as it preserves direction.
    var alpha = atan2(a, b) // calculate angle
    alpha = alpha < 0 ? alpha + (.pi * 2) : alpha // make sure angles are returned as positive values
    
    return (h, Double(alpha) * 180 / .pi)
}

print(getDistanceAndDirection(p1, p2))
