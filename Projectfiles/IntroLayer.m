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
    CCLabelTTF* gameLabel = [CCLabelTTF labelWithString:@"Play" fontName: @"Arial" fontSize:12];
    CCMenuItemLabel* gameItem = [CCMenuItemLabel itemWithLabel:gameLabel target:self selector:@selector(switchToGameLayer)];
    
    CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:@"Score" fontName: @"Arial" fontSize:12];
    CCMenuItemLabel* scoreItem = [CCMenuItemLabel itemWithLabel:scoreLabel target:self selector:@selector(switchToScoreLayer)];
    
    CCMenu * menu = [CCMenu menuWithItems:gameItem, scoreItem, nil];
    [menu alignItemsVertically];
    
    [self addChild:menu];
}

-(void) switchToGameLayer{
    CCLOG(@"Switch to Game Layer");
    [[CCDirector sharedDirector] replaceScene:[GameManager newGameScene]];
}

-(void) switchToScoreLayer{
    CCLOG(@"Switch to Score Layer");
}


@end
