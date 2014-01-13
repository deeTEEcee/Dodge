//
//  GameManager.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "IntroScene.h"
#import "GameScene.h"

static IntroScene* intro = nil;
static GameScene* game = nil;

@implementation GameManager

+(CCScene*) sharedIntroScene{
    NSAssert(intro!=nil, @"Intro is nil. Why?!!");
    return intro;
}

+(CCScene*) sharedGameScene{
     NSAssert(game!=nil, @"Game is nil. Why?!!");
    return game;
}

+(CCScene*) newGameScene{
    game = [GameScene node];
    return game;
}

-(id) init{
    // TODO: not a true singleton object yet
    
    // only need an intro layer but we need a game scene
    intro = [IntroScene node];
    game = [GameScene node];
    return self;
}

@end
