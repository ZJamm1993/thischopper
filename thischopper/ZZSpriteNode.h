//
//  ZZSpriteNode.h
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define ccp(x,y) CGPointMake(x,y)
#define ZZRandom_0_1() ((CGFloat)(arc4random()%100000/(CGFloat)100000))
#define ZZRandom_1_0_1() (ZZRandom_0_1()*(arc4random()%2==0?1:-1))

@interface ZZSpriteNode : SKSpriteNode

@property (nonatomic,assign) CGFloat speedX;

+(instancetype)defaultNode;

+(CGPoint)rotatePoint:(CGPoint)poi origin:(CGPoint)ori rotation:(CGFloat)rad;
+(CGPoint)rotateVector:(CGPoint)vec rotation:(CGFloat)rad;

@end
