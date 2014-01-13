//
//  Ball.h
//  Dodge
//
//  Created by David Chen on 1/10/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

typedef enum {
    TOP,
    BOTTOM,
    LEFT,
    RIGHT,
} Position;

extern const float BALL_SPEED;


@interface Ball : CCNode {
    
}

-(BOOL) outOfBoundary;
-(CGPoint) getRandomSpawnPoint;

@end
