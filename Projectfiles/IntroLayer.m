//
//  IntroLayer.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "IntroLayer.h"
#import "Gamelayer.h"
#import "GameManager.h"


@implementation IntroLayer

-(id) init{
    if (self = [super init]){
        [self setupMenu];
    }
    return self;
}

-(void) setupMenu{
    CCLOG(@"Setting up Menu");
    CCLabelTTF* gameLabel = [CCLabelTTF labelWithString:@"Play" fontName: @"Arial" fontSize:12];
    CCMenuItemLabel* gameItem = [CCMenuItemLabel itemWithLabel:gameLabel target:self selector:@selector(switchToGameLayer)];
    CCLOG(@"Getting manager");
    GameManager* manager = [GameManager sharedManager];
    CCLOG(@"Getting high score");
    NSInteger highScore = [manager highScore];
    CCLOG(@"Setting score string");
    NSString* scoreString = [NSString stringWithFormat:@"High Score: %d", highScore];
    CCLOG(@"Setting score label");
    CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:scoreString fontName: @"Arial" fontSize:12];
    [scoreLabel setPosition:ccp(100,50)]; // TODO: place this better
//    CCMenuItemLabel* scoreItem = [CCMenuItemLabel itemWithLabel:scoreLabel target:self selector:@selector(switchToScoreLayer)];
    
    CCMenu * menu = [CCMenu menuWithItems:gameItem, nil];
    [menu alignItemsVertically];
    
    [self addChild:menu];
    [self addChild:scoreLabel];
}

-(void) switchToGameLayer{
    CCLOG(@"Switch to Game Layer");
    [[CCDirector sharedDirector] replaceScene:[[GameManager sharedManager] newGameScene]];
}

-(void) switchToScoreLayer{
    CCLOG(@"Switch to Score Layer");
}


@end
