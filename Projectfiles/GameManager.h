//
//  GameManager.h
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

@class IntroScene;
@class GameScene;

@interface GameManager : NSObject {
    NSUserDefaults* def;
}

// readonly but we can use _varname to privately access it
@property IntroScene* introScene;
@property GameScene* gameScene;

// needed custom setter for synchronizing with the device itself
@property (getter=highScore,setter=setHighScore:) NSInteger highScore;


+(GameManager*) sharedManager;

-(NSInteger) highScore;
-(void) setHighScore:(NSInteger)highScore;
-(CCScene*) newGameScene;
-(CCScene*) newIntroScene;
-(IntroScene*) introScene;
-(GameScene*) gameScene;
-(void) setIntroScene:(IntroScene *)introScene;
-(void) setGameScene:(GameScene *)gameScene;

@end
