//
//  CrossbeamNode.h
//  thischopper
//
//  Created by jam on 17/1/28.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZSpriteNode.h"

@interface CrossbeamNode : ZZSpriteNode

@property (nonatomic,assign) BOOL passed;

+(NSArray*)createRandomDoubleBeamForScene:(SKScene*)scene;

@end
