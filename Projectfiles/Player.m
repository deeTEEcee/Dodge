//
//  Player.m
//  SnakesWithAVengeance
//
//  Created by David Chen on 1/9/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Constants.h"

static Player* activePlayer;

@implementation Player

-(id)init{
    if(self=[super init]){
        activePlayer = self;
        CCSprite* player = [CCSprite spriteWithFile:@"test.png"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.position = ccp(winSize.width/2, winSize.height/2);
        self.contentSize = [player contentSize];
        [self addChild:player];
    }
    return self;
}

+(Player*) getActivePlayer{
    return activePlayer;
}

@end
