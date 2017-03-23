//
//  CrossbeamNode.m
//  thischopper
//
//  Created by jam on 17/1/28.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CrossbeamNode.h"

const CGFloat defaultXSpacing=160;

@implementation CrossbeamNode
{
    ZZSpriteNode* chain;
    ZZSpriteNode* hammer;
}

+(instancetype)defaultNode
{
    CrossbeamNode* cr=[CrossbeamNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(320, 20)];
    return cr;
}

+(NSArray*)createRandomDoubleBeamForScene:(SKScene *)scene
{
    NSMutableArray* arr=[NSMutableArray array];
    
    CrossbeamNode* c1=[CrossbeamNode defaultNode];
    CrossbeamNode* c2=[CrossbeamNode defaultNode];
    c1.position=CGPointMake(scene.size.width/2-c1.size.width/2-defaultXSpacing/2, scene.size.height+100);
    c2.position=CGPointMake(scene.size.width/2+c1.size.width/2+defaultXSpacing/2, c1.position.y);
    c2.passed=YES;
    
    [c1 createHammerOnLeft:NO];
    [c2 createHammerOnLeft:YES];
    
    [arr addObject:c1];
    [arr addObject:c2];
    
    return [NSArray arrayWithArray:arr];
}

-(void)createHammerOnLeft:(BOOL)isLeft
{
    chain=[ZZSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(5, 80)];
    chain.anchorPoint=CGPointMake(0.5,1);
    chain.xScale=1/self.xScale;
    chain.position=CGPointMake((isLeft?-1:1)*self.size.width*0.5*0.7, 0);
    chain.zRotation=-M_PI_4;
    [self addChild:chain];
    
    hammer=[ZZSpriteNode spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(40, 40)];
    hammer.position=CGPointMake(0, -chain.size.height);
    [chain addChild:hammer];
    
    SKAction* rotation1=[SKAction rotateToAngle:M_PI_4 duration:4 shortestUnitArc:YES];
    rotation1.timingMode=SKActionTimingEaseInEaseOut;
    
    SKAction* rotation2=[SKAction rotateToAngle:-M_PI_4 duration:4 shortestUnitArc:YES];
    rotation2.timingMode=SKActionTimingEaseInEaseOut;
    
    SKAction* oscillate=[SKAction repeatActionForever:[SKAction sequence:[NSArray arrayWithObjects:rotation1,rotation2, nil]]];
    
    [chain runAction:oscillate];
}

@end
