//
//  ZZSpriteNode.m
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZSpriteNode.h"

@implementation ZZSpriteNode

+(instancetype)defaultNode
{
    return [ZZSpriteNode spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(10, 10)];
}

+(CGPoint)rotateVector:(CGPoint)vec rotation:(CGFloat)rad
{
    CGFloat x=vec.x*cos(rad)-vec.y*sin(rad);
    CGFloat y=vec.x*sin(rad)+vec.y*cos(rad);
    return CGPointMake(x, y);
}

+(CGPoint)rotatePoint:(CGPoint)poi origin:(CGPoint)ori rotation:(CGFloat)rad
{
    CGPoint tempPoint=CGPointMake(poi.x-ori.x, poi.y-ori.y);
    CGPoint rotatedPoint=[self rotateVector:tempPoint rotation:rad];
    CGPoint newPoint=CGPointMake(rotatedPoint.x+ori.x,rotatedPoint.y+ori.y);
    return newPoint;
}

@end
