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

-(void)crashWithPieces
{
    [wing removeFromParent];
    [wing removeAllActions];
    
//    CGPoint oldPoint=self.position;
//    CFTimeInterval shakeDuration=0.02;
//    CGFloat shakeRadius=2;
//    
//    NSMutableArray* shakeActions=[NSMutableArray array];
//    for (int i=0; i<4; i++) {
//        [shakeActions addObject:[SKAction moveTo:CGPointMake(oldPoint.x+shakeRadius*ZZRandom_1_0_1(), oldPoint.y+shakeRadius*ZZRandom_1_0_1()) duration:shakeDuration]];
//    }
//    [shakeActions addObject:[SKAction moveTo:oldPoint duration:shakeDuration]];
    
    CFTimeInterval defDuration=1;
    CGFloat wingOffsetX=100;
    
    SKAction* rota=[SKAction rotateToAngle:M_PI*8 duration:defDuration];
    
    SKAction* flyUp=[SKAction moveByX:0 y:self.size.height*1 duration:defDuration/2];
    flyUp.timingMode=SKActionTimingEaseOut;
    SKAction* flyDown=[SKAction moveByX:0 y:-self.size.height*1.5 duration:defDuration/2];
    flyDown.timingMode=SKActionTimingEaseIn;
    
    SKAction* parabola=[SKAction sequence:[NSArray arrayWithObjects:flyUp, flyDown, nil]];
    
    ZZSpriteNode* lw=[ZZSpriteNode spriteNodeWithColor:wing.color size:CGSizeMake(self.size.width/2, 5)];
    lw.position=self.position;
    [self.parent addChild:lw];
    [lw runAction:[SKAction group:[NSArray arrayWithObjects:[SKAction moveByX:-wingOffsetX y:0 duration:defDuration],rota,parabola,nil]]];
    
    ZZSpriteNode* rw=[ZZSpriteNode spriteNodeWithColor:wing.color size:lw.size];
    rw.position=lw.position;
    [self.parent addChild:rw];
    [rw runAction:[SKAction group:[NSArray arrayWithObjects:[SKAction moveByX:wingOffsetX y:0 duration:defDuration],rota,parabola,nil]]];
    
    SKAction* rotation=[SKAction rotateToAngle:M_PI+(1*2*M_PI) duration:defDuration];
    [self runAction:rotation];
}

@end
