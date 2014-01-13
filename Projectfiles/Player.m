//
//  Player.m
//  SnakesWithAVengeance
//
//  Created by David Chen on 1/9/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

-(id)init{
    if(self=[super init]){
        CCSprite* player = [CCSprite spriteWithFile:@"test.png"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:player];
    }
    return self;
}

@end
