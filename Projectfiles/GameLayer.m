/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "GameLayer.h"
#import "Ball.h"
#import "Player.h"

@implementation GameLayer

-(id) init
{
	if (self = [super init])
	{
        [self setTouchEnabled: YES];
        _ball = [Ball node];
        _player = [Player node];
        
        [self addChild:_ball];
        [self addChild:_player];
        
        double slope = (_player.position.y-_ball.position.y)/(_player.position.x-_ball.position.x);
        CGFloat x2;
        CGFloat y2;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if ([_player position].x>[_ball position].x){
            x2 = winSize.width+[_ball boundingBox].size.width/2;
        }
        else if([_player position].x<[_ball position].x){
            x2 = 0-[_ball boundingBox].size.width/2;
        }
        y2 = _ball.position.y+slope*(x2-_ball.position.x); // y2 = y1+m(x2-x1)
        
        CGPoint dest = ccp(x2,y2);
        [_ball runAction:[CCMoveTo actionWithDuration:ccpDistance(_ball.position,dest)/BALL_SPEED position:dest]];
        
        [self schedule:@selector(updateObjects:)];
        [self schedule:@selector(updatePlayer:)];
        CCLOG(@"initialized");
	}
    
	return self;
}

-(void) updateObjects:(ccTime)deltaTime{
    
    
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    touchData.inUse = YES;
    CGPoint pos = [touch locationInView:touch.view];
    pos = [[CCDirector sharedDirector] convertToGL:pos];
    pos = [self convertToNodeSpace:pos];
    touchData.position = pos;
    return true;
    
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint pos = [touch locationInView:touch.view];
    pos = [[CCDirector sharedDirector] convertToGL:pos];
    pos = [self convertToNodeSpace:pos];
    touchData.position = pos;
}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    touchData.inUse = NO;
}
-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    //    CCLOG(@"TouchCancelled");
}

-(void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) setPlayerPosition:(CGPoint) position{
    //    CGPoint currentPosition = _player.position;
    _player.position = position;
//    if (CGRectIntersectsRect([_snake boundingBox],[_player boundingBox])){
//        // game over
//    }
}

-(void) updatePlayer:(ccTime)deltaTime {
    // touch + movement
    if(touchData.inUse){
        //        CCLOG(@"Bear is at: %@", CGPointCreateDictionaryRepresentation(self.bear.position));
//        CCLOG(@"Touch position is at: %@", CGPointCreateDictionaryRepresentation(touchData.position));
        CGPoint playerPos = [_player position];
        CGSize playerSize = [_player boundingBox].size;
        CGPoint playerWorldPos = [self convertToWorldSpace:playerPos];
        CGPoint diff = ccpSub(touchData.position, playerWorldPos);
        CGFloat dxy = PLAYER_SPEED * deltaTime;
        /* To explain, we check the following:
            - touch is outside the player boundary
            - touch is in the right direction
            - touch has to be farther than where the player is about to move
         */
        // right
        if(diff.x>playerSize.width/2 && touchData.position.x>playerPos.x && fabs(diff.x)>=dxy){
//            CCLOG(@"RIGHT");
            playerPos.x += dxy;
        }
        // left
        else if(diff.x<-playerSize.width/2 && touchData.position.x<playerPos.x && fabs(diff.x)>=dxy){
//            CCLOG(@"LEFT");
            playerPos.x -= dxy;
        }
        // up
        if(diff.y>playerSize.height/2 && touchData.position.y>playerPos.y && fabs(diff.y)>=dxy){
//            CCLOG(@"UP");
            playerPos.y += dxy;
        }
        // down
        else if(diff.y<-playerSize.height/2 && touchData.position.y<playerPos.y && fabs(diff.y)>=dxy){
//            CCLOG(@"DOWN");
            playerPos.y -= dxy;
        }
        [self setPlayerPosition:playerPos];
    }
    
}


@end
