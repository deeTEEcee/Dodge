/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

@class Player;
@class Ball;
#import "kobold2d.h"


@interface GameLayer : CCLayer
{
    struct {
        CGPoint position;
        BOOL inUse;
    } touchData; // why? actually, it's probably better to use this as a static varaible but i just wanted to use this outside the touch functions
}

@property NSMutableArray* balls;
@property Player* player;
@property NSInteger score;
@property NSInteger difficulty;

-(void) restart; // restart the game
-(void) clear:(NSMutableArray*)balls;

-(void) update:(ccTime)delta;
-(void) updatePlayer:(ccTime)deltaTime;
-(void) setPlayerPosition:(CGPoint) position;

-(void) spawnRegularBalls:(ccTime)deltaTime;
-(void) spawnCircleBalls:(ccTime)deltaTime;
-(void) cleanupBalls:(ccTime)deltaTime;

-(void) updateDifficulty:(ccTime)deltaTime;
-(void) updateScore:(ccTime)deltaTime;

// game over related
-(BOOL) collisionExists;
-(void) setupGameOverMenu;
-(void) switchToMenuLayer;
-(void) gameOver;

// overridden methods
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) registerWithTouchDispatcher;

@end
