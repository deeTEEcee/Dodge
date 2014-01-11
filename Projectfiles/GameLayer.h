/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "kobold2d.h"

@class Player;
@class Ball;

@interface GameLayer : CCLayer
{
    struct {
        CGPoint position;
        BOOL inUse;
    } touchData; // why? actually, it's probably better to use this as a static varaible but i just wanted to use this outside the touch functions
}

@property Ball* ball;
@property Player* player;
-(void) updateObjects:(ccTime)deltaTime;
-(void) updatePlayer:(ccTime)deltaTime;

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) registerWithTouchDispatcher;

@end