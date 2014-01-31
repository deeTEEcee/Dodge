//
//  GameManager.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "IntroScene.h"
#import "GameScene.h"

static IntroScene* intro = nil;
static GameScene* game = nil;
static NSUserDefaults* def = nil;

@implementation GameManager

@synthesize highScore=_highScore; // if getter, setter is self-defined, synthesize is not auto-synthesized by compiler

+(CCScene*) sharedIntroScene{
    NSAssert(intro!=nil, @"Intro is nil. Why?!!");
    return intro;
}

+(CCScene*) sharedGameScene{
     NSAssert(game!=nil, @"Game is nil. Why?!!");
    return game;
}

+(CCScene*) newGameScene{
    CCLOG(@"New Game Scene");
    game = [GameScene node];
    return game;
}

+(CCScene*) newIntroScene{
    CCLOG(@"New Intro Scene");
    intro = [IntroScene node];
    return intro;
}

-(id) init{
    // TODO: not a true singleton object yet
    if( self = [super init]){
        def = [NSUserDefaults standardUserDefaults];
        self.highScore = [def integerForKey:@"highScore"];
        CCLOG(@"Saved Score: %ld", self.highScore);
        self.highScore += 5;
        CCLOG(@"New Score: %ld", self.highScore);
//        [def setInteger:self.score forKey:@"score"];
//        [def synchronize];
        // only need an intro layer but we need a game scene
        intro = [IntroScene node];
        //    game = [GameScene node];
    }
    return self;
}

-(NSInteger) highScore{
    return _highScore;
}

-(void) setHighScore:(NSInteger) newScore{
    _highScore = newScore;
    [def setInteger:_highScore forKey:@"highScore"];
    [def synchronize];
}

@end
