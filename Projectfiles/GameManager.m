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

@implementation GameManager

@synthesize highScore=_highScore; // if getter, setter is self-defined, synthesize is not auto-synthesized by compiler

+(GameManager*) sharedManager {
    static GameManager* instance = nil;
    CCLOG(@"NEW INSTANCE");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GameManager alloc] init];
    });
    CCLOG(@"INSTANCE INITED");
    return instance;
}

-(CCScene*) newGameScene{
    CCLOG(@"New Game Scene");
    _gameScene = [GameScene node];
    return _gameScene;
}

-(CCScene*) newIntroScene{
    CCLOG(@"New Intro Scene");
    _introScene = [IntroScene node];
    return _introScene;
}

-(id) init{
    if( self = [super init]){
        def = [NSUserDefaults standardUserDefaults];
        self.highScore = [def integerForKey:@"highScore"];
        CCLOG(@"Saved Score: %d", self.highScore);
        self.highScore += 5;
        CCLOG(@"New Score: %d", self.highScore);
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
