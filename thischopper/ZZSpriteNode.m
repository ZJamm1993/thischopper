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

@end
