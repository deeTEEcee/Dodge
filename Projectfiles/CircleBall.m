//
//  CircleBall.m
//  Dodge
//
//  Created by David Chen on 2/18/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "CircleBall.h"
#import "Ball.h"
#import "Constants.h"
#import "Global.h"
#import "Player.h"


@implementation CircleBall

-(id)init{
    if(self=[super init]){
    }
    return self;
}

-(void) initBall{
    aimAtTarget = false;
    int random = arc4random() % 2;
    if(random==0){
        moveClockwise = true;
    }
    else{
        moveClockwise = false;
    }
    CCSprite* ball = [CCSprite spriteWithFile:@"ball-strange.png"];
    self.position = [self getRandomSpawnPoint];
    self.contentSize = [ball contentSize];
    [self addChild:ball];
    [self scheduleUpdate];
}

// for balls that can't need custom actions, we need update
// we want to move the circle ball in a circle but at the same time go towards the center which just scares the player
-(void) update:(ccTime)delta{
    CCLOG(@"updating myself");
    if(!aimAtTarget){
        // go for the center
        
        [self moveTowardsCenter:delta];
        [self moveInACircle:delta];
        
    }
    else{
        target = [Player getActivePlayer].position;
        // attack the target and then unschedule yourself
        [self lineAttack:target];
        [self unscheduleAllSelectors];
    }
}

-(void) moveTowardsCenter:(ccTime)delta {
    CCLOG(@"Old position: %@", NSStringFromCGPoint(self.position));
    CGFloat newX = self.position.x;
    CGFloat newY = self.position.y;
    CGFloat dxy = CIRCLE_BALL_CENTER_SPEED*delta;
    CGPoint center = ccp(WIN_SIZE.width/2, WIN_SIZE.height/2);
    CGPoint diff = ccpSub(center, self.position);
    if(diff.x>0 && fabs(diff.x)>dxy){
        newX = self.position.x + dxy;
    }
    else if(diff.x<0 && fabs(diff.x)>dxy){
        newX = self.position.x - dxy;
    }
    
    if(diff.y>0 && fabs(diff.y)>dxy){
        newY = self.position.y + dxy;
    }
    else if(diff.y<0 && fabs(diff.y)>dxy){
        newY = self.position.y - dxy;
    }
    if(self.position.x == newX && self.position.y == newY){
        aimAtTarget = true;
        return;
    }
    
    self.position = ccp(newX, newY);
    
    CCLOG(@"New position: %@", NSStringFromCGPoint(self.position));
    
}

-(void) moveInACircle:(ccTime)delta {
    CGPoint center = ccp(WIN_SIZE.width/2, WIN_SIZE.height/2);
    CGPoint diff = ccpSub(self.position, center);
    CGFloat hyp = ccpLength(diff);
    CGFloat angle = ccpToAngle(diff);
    // only move in a circle when it won't move out of the screen (radius has to be smaller than the width&height half)
    if(hyp> WIN_SIZE.width/2 || hyp>WIN_SIZE.height/2){
        return;
    }
    if(moveClockwise){
        angle += 1.2*delta;
    }
    else{
        angle -= 1.2*delta;
    }
    
    self.position = ccp(center.x+fabs(hyp)*cosf(angle), center.y+fabs(hyp)*sinf(angle));
    
}

@end
