//
//  CGPoint+Ext.swift
//  GameChallange
//
//  Created by sumaiya on 15/12/2566 BE.
//
//I use it to change the camera and ground
import Foundation
import CoreGraphics

func + (left:CGPoint,right:CGPoint)-> CGPoint{
    return CGPoint(x: left.x+right.x, y: left.y+right.y)
    
}

func += (left:inout CGPoint,right:CGPoint){
    left=left+right
    
}

//
func - (left:CGPoint,right:CGPoint)-> CGPoint{
    return CGPoint(x: left.x-right.x, y: left.y-right.y)
    
}

func -= (left:inout CGPoint,right:CGPoint){
    left=left-right
    
}
//

func * (left:CGPoint,right:CGPoint)-> CGPoint{
    return CGPoint(x: left.x*right.x, y: left.y*right.y)
    
}

func *= (left:inout CGPoint,right:CGPoint){
    left=left*right
    
}
//
func / (left:CGPoint,right:CGPoint)-> CGPoint{
    return CGPoint(x: left.x/right.x, y: left.y/right.y)
    
}

func /= (left:inout CGPoint,right:CGPoint){
    left=left*right
    
}
//diffrenc

func * (point:CGPoint,scalar:CGFloat)-> CGPoint{
    return CGPoint(x: point.x * scalar, y: point.y*scalar)
    
}

func *= (point:inout CGPoint,scalar:CGFloat){
   point = point * scalar
    
}


//

func / (point:CGPoint,scalar:CGFloat)-> CGPoint{
    return CGPoint(x: point.x / scalar, y: point.y/scalar)
    
}

func /= (point:inout CGPoint,scalar:CGFloat){
   point = point / scalar
    
}


