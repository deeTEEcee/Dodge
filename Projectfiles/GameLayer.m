/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "GameLayer.h"
#import "Ball.h"
#import "Player.h"
#import "GameManager.h"
#import "Constants.h"

static CGSize WIN_SIZE;

@implementation GameLayer

-(id) init
{
	if (self = [super init])
	{
        self.score = 0;
        [self setTouchEnabled: YES];
        WIN_SIZE = [[CCDirector sharedDirector] winSize];
        
        _balls = [NSMutableArray array];
        _player = [Player node];
        
        [self scheduleUpdate];
        [self schedule:@selector(updateObjects:) interval:0.8];
        [self schedule:@selector(updateScore:) interval:1.0];
        
        [self addChild:_player];
        CCLOG(@"gamelayer initialized");
	}
    
	return self;
}

-(Ball*) spawnBall{
    Ball* ball = [Ball node];
    [self addChild:ball];
    
    double slope = (_player.position.y-ball.position.y)/(_player.position.x-ball.position.x);
    CGFloat x2;
    CGFloat y2;
    if ([_player position].x>[ball position].x){
        x2 = WIN_SIZE.width+[ball boundingBox].size.width/2;
    }
    else if([_player position].x<[ball position].x){
        x2 = 0-[ball boundingBox].size.width/2;
    }
    y2 = ball.position.y+slope*(x2-ball.position.x); // y2 = y1+m(x2-x1)
    
    CGPoint dest = ccp(x2,y2);
    [ball runAction:[CCMoveTo actionWithDuration:ccpDistance(ball.position,dest)/BALL_SPEED position:dest]];
    return ball;
}

-(void) updateScore:(ccTime)deltaTime{
    self.score += deltaTime;
}

-(void) updateObjects:(ccTime)deltaTime{
    Ball* newBall = [self spawnBall];
    NSMutableArray* ballsToCleanUp = [NSMutableArray array];
    for(Ball* ball in _balls){
        if([ball outOfBoundary]){
            [ballsToCleanUp addObject:ball];
        }
    }
    [_balls addObject:newBall];
    [self clear:ballsToCleanUp];
    
}

-(void) clear:(NSMutableArray*) balls{
    for(Ball* ball in balls){
        [self removeChild:ball];
        [_balls removeObject:ball];
    }
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
    // game over
    //    }
}

-(void) update:(ccTime)delta{
    [self updatePlayer:delta];
    CCLOG(@"Player position: %@", NSStringFromCGPoint(self.player.position));
    // check collisions
    if ([self collisionExists]){
        CCLOG(@"Collided");
        [self gameOver];
    }
    CCLOG(@"new score: %d", self.score);
}

-(void) updatePlayer:(ccTime)deltaTime {
    // touch + movement
    if(touchData.inUse){
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

-(BOOL) collisionExists{
    for(Ball* ball in _balls){
        CCLOG(@"Ball position: %@", NSStringFromCGPoint(ball.position));
        if (CGRectIntersectsRect([ball boundingBox],[_player boundingBox])){
            return true;
        }
    }
    return false;
}

-(void) setupGameOverMenu{
    // TODO: technically, this should be its own object (by default, cocos2d doesn't look like it has any way of implementing a menu with a title... which is stupid
    CCLabelTTF* label = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Arial" fontSize:12];
    label.position = ccp(WIN_SIZE.width/2, WIN_SIZE.height/2);
    [self addChild:label];
    
    CCLabelTTF* restartLabel = [CCLabelTTF labelWithString:@"Restart" fontName: @"Arial" fontSize:12];
    CCMenuItemLabel* restartItem = [CCMenuItemLabel itemWithLabel:restartLabel target:self selector:@selector(restart)];
    
    CCLabelTTF* menuLabel = [CCLabelTTF labelWithString:@"Main Menu" fontName: @"Arial" fontSize:12];
    CCMenuItemLabel* menuItem = [CCMenuItemLabel itemWithLabel:menuLabel target:self selector:@selector(switchToMenuLayer)];
    
    CCMenu * menu = [CCMenu menuWithItems:restartItem, menuItem, nil];
    [menu alignItemsVertically];
    CCLOG(@"Menu position %@", NSStringFromCGPoint(menu.position));
    menu.position = ccpSub(label.position, ccp(0,[label boundingBox].size.height*2));
    CCLOG(@"Menu position %@", NSStringFromCGPoint(menu.position));
    
    [self addChild:menu];
}

-(void) restart{
    [[CCDirector sharedDirector] replaceScene:[GameManager newGameScene]];
}

-(void) switchToMenuLayer{
    [[CCDirector sharedDirector] replaceScene:[GameManager newIntroScene]];
}

-(void) gameOver {
    // display (todo: move over to hud display)
    [self setupGameOverMenu];
    
    // when the game is over, all updates cease (note: a few balls are not removed, im assuming they get removed when we reinitialize this layer)
    [self unscheduleAllSelectors];
}


@end
