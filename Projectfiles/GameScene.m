//
//  GameScene.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"


@implementation GameScene

-(id) init{
    CCLOG(@"Game Scene Initialized");
    if(self=[super init]){
        GameLayer* gameLayer = [GameLayer node];
        [self addChild:gameLayer];
    }
    return self;
}

@end
