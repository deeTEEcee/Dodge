//
//  Ball.m
//  Dodge
//
//  Created by David Chen on 1/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"

static CGSize WIN_SIZE;
const float BALL_SPEED = 100.0;

@implementation Ball

-(id)init{
    if(self=[super init]){
        CCSprite* ball = [CCSprite spriteWithFile:@"ball-normal.png"];
        WIN_SIZE = [[CCDirector sharedDirector] winSize];
        self.position = [self getRandomSpawnPoint];
        self.contentSize = [ball contentSize];
        [self addChild:ball];
    }
    return self;
}

-(CGPoint) getRandomSpawnPoint{
    Position pos = arc4random() % 4;
    CGFloat offset = (CGFloat) (arc4random() % (int) WIN_SIZE.width);
    switch(pos){
        case BOTTOM:
            return ccp(offset,0-[self boundingBox].size.height/2);
        case TOP:
            return ccp(offset, WIN_SIZE.height+[self boundingBox].size.height/2);
        case LEFT:
            return ccp(0-[self boundingBox].size.width/2, offset);
        case RIGHT:
            return ccp(WIN_SIZE.width+[self boundingBox].size.width/2, offset);
    }
    [NSException raise:@"Invalid Position" format:@"Position: %d", pos];
}

-(BOOL) outOfBoundary{
    if(self.position.x <= -[self boundingBox].size.width/2 || self.position.x >= WIN_SIZE.width+[self boundingBox].size.width/2){
        return true;
    }
    if(self.position.y <= -[self boundingBox].size.height/2 || self.position.y>= WIN_SIZE.height+[self boundingBox].size.height/2){
        return true;
    }
    return false;
}

@end
