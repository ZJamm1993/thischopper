//
//  ChopperNode.m
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ChopperNode.h"

@implementation ChopperNode
{
    ZZSpriteNode* wing;
}

+(instancetype)defaultNode
{
    ChopperNode* chop=[ChopperNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(30, 40)];
    
    [chop showWings];
    
    return chop;
}

-(void)showWings
{
    wing=[ZZSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(self.size.width*1.5, 5)];
    wing.position=CGPointMake(0, self.size.height/2+10);
    [self addChild:wing];

    ZZSpriteNode* eye=[ZZSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(3, 3)];
    eye.position=CGPointMake(0, 10);
    [self addChild:eye];
}

-(void)startEngine
{
    CFTimeInterval roT=0.1;
    SKAction* rep=[SKAction repeatActionForever:[SKAction sequence:[NSArray arrayWithObjects:[SKAction scaleXTo:0.2 duration:roT],[SKAction scaleXTo:1 duration:roT], nil]]];
    [wing runAction:rep];
}

@end
