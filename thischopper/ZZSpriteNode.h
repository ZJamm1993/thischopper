//
//  ZZSpriteNode.h
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZZSpriteNode : SKSpriteNode

@property (nonatomic,assign) CGFloat speedX;

+(instancetype)defaultNode;

+(CGPoint)rotatePoint:(CGPoint)poi origin:(CGPoint)ori rotation:(CGFloat)rad;
+(CGPoint)rotateVector:(CGPoint)vec rotation:(CGFloat)rad;

@end
