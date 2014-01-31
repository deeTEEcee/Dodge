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
}

@property (getter=highScore, setter=setHighScore:) NSInteger highScore;

+(CCScene*) sharedIntroScene;
+(CCScene*) sharedGameScene;
+(CCScene*) newGameScene;
+(CCScene*) newIntroScene;

@end
