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

+(CCScene*) sharedIntroScene;
+(CCScene*) sharedGameScene;
+(CCScene*) newGameScene;

@end
