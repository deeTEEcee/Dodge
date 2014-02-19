//
//  Ball.m
//  Dodge
//
//  Created by David Chen on 1/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "Constants.h"
#import "Global.h"

@implementation Ball

-(id)init{
    if(self=[super init]){
        target = ccp(NAN, NAN);
        [self initBall];
    }
    return self;
}

-(void) initBall{
    CCSprite* ball = [CCSprite spriteWithFile:@"ball-normal.png"];
    self.position = [self getRandomSpawnPoint];
    self.contentSize = [ball contentSize];
    [self addChild:ball];
}


/*
 What we did here:
 1. Find the slope knowing the ball and player's position
 2. Choose an x position that is obviously off the screen (so we choosing one that entails the entire width of the screen)
 3. Plug the random x2 into the line equation and we get the resulting y2 that we want as well
 */
-(void) target:(CGPoint) position{
    target = position;
    [self lineAttack:position];
}

-(void) lineAttack:(CGPoint) position{
    double slope = (position.y-self.position.y)/(position.x-self.position.x);
    CGFloat x2;
    CGFloat y2;
    if (position.x>[self position].x){
        x2 = WIN_SIZE.width+[self boundingBox].size.width/2;
    }
    else if(position.x<[self position].x){
        x2 = 0-[self boundingBox].size.width/2;
    }
    y2 = self.position.y+slope*(x2-self.position.x); // y2 = y1+m(x2-x1)
    
    CGPoint dest = ccp(x2,y2);
    [self runAction:[CCMoveTo actionWithDuration:ccpDistance(self.position,dest)/DEFAULT_BALL_SPEED position:dest]];
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
