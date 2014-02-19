//
//  Ball.h
//  Dodge
//
//  Created by David Chen on 1/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

@class Player;


typedef enum {
    TOP,
    BOTTOM,
    LEFT,
    RIGHT,
} Position;

@interface Ball : CCNode {
    CGPoint target;
}



// main function for action
-(void) initBall;
-(void) target:(CGPoint) position;
-(void) lineAttack:(CGPoint) position;

// private functions
-(BOOL) outOfBoundary;
-(CGPoint) getRandomSpawnPoint;

@end
