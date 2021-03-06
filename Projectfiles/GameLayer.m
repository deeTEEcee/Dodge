/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "GameLayer.h"
#import "Ball.h"
#import "CircleBall.h"
#import "Player.h"
#import "GameManager.h"
#import "Constants.h"
#import "Global.h"
#import "SimpleAudioEngine.h"

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
        
        
        // update player movement based on touch and also collision statuses (since this is checked instantly)
        [self scheduleUpdate];
        
        // update the balls for spawning and removal from memory
        [self schedule:@selector(spawnRegularBalls:) interval:0.8];
        [self schedule:@selector(cleanupBalls:) interval:0.8];
        
        // update the score (HUD-related)
        [self schedule:@selector(updateDifficulty:) interval:5.0];
        [self schedule:@selector(updateScore:) interval:1.0];
        
        [self addChild:_player];
        
        CCLOG(@"gamelayer initialized");
	}
    
	return self;
}

// TODO: obviously, this is a bit repetitive with the spawning of balls so refactor
-(void) spawnRegularBalls:(ccTime)deltaTime{
    // spawn balls
    Ball* newBall = [Ball node];
    [self addChild:newBall];
    [newBall target:_player.position];
    [_balls addObject:newBall];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"ball.wav"];
    
}

-(void) spawnCircleBalls:(ccTime)deltaTime{
    // spawn balls
    CircleBall* newBall = [CircleBall node];
    [self addChild:newBall];
    [_balls addObject:newBall];
}

-(void) cleanupBalls:(ccTime)deltaTime{
    // remove balls
    NSMutableArray* ballsToCleanUp = [NSMutableArray array];
    for(Ball* ball in _balls){
        if([ball outOfBoundary]){
            [ballsToCleanUp addObject:ball];
        }
    }
    [self clear:ballsToCleanUp];
}

-(void) clear:(NSMutableArray*) balls{
    for(Ball* ball in balls){
        [self removeChild:ball];
        [_balls removeObject:ball];
    }
}

// runs every 30 seconds
-(void) updateDifficulty:(ccTime)deltaTime{
    self.difficulty += 1;
    if(self.difficulty==1){
        [self schedule:@selector(spawnCircleBalls:) interval:8.0];
    }
}

-(void) updateScore:(ccTime)deltaTime{
    self.score += deltaTime;
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
        [[SimpleAudioEngine sharedEngine] playEffect:@"slap.mp3"];
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
            playerPos.x += dxy;
        }
        // left
        else if(diff.x<-playerSize.width/2 && touchData.position.x<playerPos.x && fabs(diff.x)>=dxy){
            playerPos.x -= dxy;
        }
        // up
        if(diff.y>playerSize.height/2 && touchData.position.y>playerPos.y && fabs(diff.y)>=dxy){
            playerPos.y += dxy;
        }
        // down
        else if(diff.y<-playerSize.height/2 && touchData.position.y<playerPos.y && fabs(diff.y)>=dxy){
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
    // TODO: technicalÏly, this should be its own object (by default, cocos2d doesn't look like it has any way of implementing a menu with a title... which is stupid
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
    [[CCDirector sharedDirector] replaceScene:[[GameManager sharedManager] newGameScene]];
}

-(void) switchToMenuLayer{
    [[CCDirector sharedDirector] replaceScene:[[GameManager sharedManager] newIntroScene]];
}

-(void) gameOver {
    // display (todo: move over to hud display)
    [self setupGameOverMenu];
    
    // update the highest score
    GameManager* manager = [GameManager sharedManager];
    if(self.score>[manager highScore]){
        [manager setHighScore:self.score];
    }
    
    // when the game is over, all updates cease (note: a few balls are not removed, im assuming they get removed when we reinitialize this layer)
    [self unscheduleAllSelectors];
}


@end
