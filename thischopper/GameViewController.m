//
//  GameViewController.m
//  thischopper
//
//  Created by jam on 17/1/27.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import <GameKit/GameKit.h>

@implementation GameViewController
{
    SKView* skView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    skView = [[SKView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:skView];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount=YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene sceneWithSize:skView.frame.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    GKLocalPlayer* localPlayer=[GKLocalPlayer localPlayer];
    [localPlayer setAuthenticateHandler:^(UIViewController * viewController , NSError * error) {
        NSLog(@"error:%@",error);
        if (viewController!=nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else
        {
            NSLog(@"player:%@",[GKLocalPlayer localPlayer].description);
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
