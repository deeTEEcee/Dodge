//
//  GameScene.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"
#import "HUDLayer.h"

static GameLayer* gameLayer = nil;
static HUDLayer* hudLayer = nil;

@implementation GameScene

-(id) init{
    CCLOG(@"Game Scene Initialized");
    if(self=[super init]){
        gameLayer = [GameLayer node];
        hudLayer = [HUDLayer node];
        [self addChild:gameLayer];
        [self addChild:hudLayer];
    }
    return self;
}

+(GameLayer*) sharedGameLayer{
    return gameLayer;
}

@end
