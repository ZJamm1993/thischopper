//
//  GameScene.m
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "GameScene.h"
#import "ZZSpriteNode.h"
#import "ChopperNode.h"
#import "CrossbeamNode.h"

const CGFloat defaultGG=800.0;
const CGFloat defaultFallingSpeed=100;
const CGFloat defaultYSpacing=180;
const CFTimeInterval defaultCreateObjectFreq=defaultYSpacing/defaultFallingSpeed;

@implementation GameScene
{
    CGFloat g;
    CFTimeInterval lastTime;
    ChopperNode* chopper;
    ZZSpriteNode* ground;
    CFTimeInterval lastCreateTime;
    BOOL shouldCreateObjects;
    BOOL isGameOver;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.backgroundColor=[SKColor blackColor];
    
    ground=[ZZSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(self.size.width,self.size.height*0.3)];
    ground.position=CGPointMake(self.size.width/2, ground.size.height/2);
    [self addChild:ground];
    
    chopper=[ChopperNode defaultNode];
    chopper.position=CGPointMake(self.size.width/2, ground.size.height+chopper.size.height/2);
    [self addChild:chopper];
    
    [chopper startEngine];
    [chopper runAction:[SKAction waitForDuration:2] completion:^{
        g=defaultGG*0.3;
        [ground runAction:[SKAction moveToY:-ground.size.height/2 duration:1] completion:^{
            shouldCreateObjects=YES;
        }];
    }];
}

-(void)createTwoCrossBeams;
{
    NSArray* beams=[CrossbeamNode createRandomDoubleBeamForScene:self];
    CGFloat randomOffSet=64*ZZRandom_1_0_1();
    for (CrossbeamNode* be in beams) {
        be.position=CGPointMake(be.position.x+randomOffSet, be.position.y);
        
        [self addChild:be];
        
        [be runAction:[SKAction moveToY:-be.size.height duration:self.size.height/defaultFallingSpeed] completion:^{
            [be removeFromParent];
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(g>0)
    {
        g=-defaultGG;
    }
    else
    {
        g=defaultGG;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (isGameOver) {
        return;
    }
    
    CFTimeInterval deltaTime=currentTime-lastTime;
    lastTime=currentTime;
    
    if (deltaTime>=1.0) {
        return;
    }
    
    /////////////
    //the animation of chopper;
    
    CGFloat rotation=0;
    if (g!=0) {
        rotation=(g>0?-1:1)*M_PI_4;
        [chopper runAction:[SKAction rotateToAngle:rotation duration:0.5]];
    }
    
    chopper.position=CGPointMake(chopper.position.x+chopper.speedX*deltaTime,chopper.position.y);
    
    chopper.speedX=chopper.speedX+g*deltaTime;
    
    CGFloat maxSpeed=defaultGG;
    if(chopper.speedX>maxSpeed)
    {
        chopper.speedX=maxSpeed;
    }
    else if(chopper.speedX<-maxSpeed)
    {
        chopper.speedX=-maxSpeed;
    }
    
    if ((chopper.position.x+chopper.size.width/2)<0) {
        chopper.position=CGPointMake(self.size.width+chopper.size.width/2, chopper.position.y);
    }
    if ((chopper.position.x-chopper.size.width/2)>self.size.width) {
        chopper.position=CGPointMake(-chopper.size.width/2, chopper.position.y);
    }
    
    ///////////
    //the logic of creating beams;
    
    if (shouldCreateObjects) {
        if (currentTime-lastCreateTime>=defaultCreateObjectFreq) {
            lastCreateTime=currentTime;
            [self createTwoCrossBeams];
        }
    }
    
    ///////////
    //the logic of intersects;
    
    NSMutableArray* beams=[NSMutableArray array];
    for (SKNode* nod in self.children) {
        if ([nod isKindOfClass:[CrossbeamNode class]]) {
            [beams addObject:nod];
        }
    }
    
    for (CrossbeamNode* beam in beams) {
        if ([beam intersectsNode:chopper]) {
            [self gameOver];
            return;
        }
    }
}
             
-(void)gameOver
{
    isGameOver=YES;
    
    CFTimeInterval fallingTime=1;
    
    for (SKNode* child in self.children) {
        if ([child isKindOfClass:[CrossbeamNode class]]) {
            [child removeAllActions];
            [child runAction:[SKAction moveByX:0 y:self.size.height*2 duration:fallingTime]];
        }
    }
    
    SKNode* wing=chopper.children.firstObject?chopper.children.firstObject:[SKNode node];
    [wing removeFromParent];
    wing.position=CGPointMake(chopper.position.x,chopper.position.y+chopper.size.height/2);
    [wing removeAllActions];
    wing.xScale=1;
    wing.yScale=1;
    [chopper.parent addChild:wing];
    
    SKAction* rotation=[SKAction rotateToAngle:M_PI+(1*2*M_PI) duration:fallingTime shortestUnitArc:NO];
    SKAction* rotation2=[SKAction rotateToAngle:M_PI+(4*2*M_PI) duration:fallingTime shortestUnitArc:NO];
    [chopper runAction:[SKAction group:[NSArray arrayWithObjects:rotation,[SKAction moveByX:-20 y:0 duration:fallingTime], nil]]];
    [wing runAction:[SKAction group:[NSArray arrayWithObjects:rotation2,[SKAction moveByX:50 y:-chopper.size.height duration:fallingTime], nil]]];
    
    [ground runAction:[SKAction moveTo:CGPointMake(self.size.width/2, ground.size.height/2) duration:fallingTime] completion:^{
        
        [self performSelector:@selector(restartGame) withObject:nil afterDelay:2];
    }];
}

-(void)restartGame
{
    GameScene *scene = [GameScene sceneWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    [self.view presentScene:scene];
}

@end
