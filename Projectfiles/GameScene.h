//
//  GameScene.h
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//
#import "GameLayer.h" // HUDLayer needs access to this
@class HUDLayer;


@interface GameScene : CCScene {
}

//@property GameLayer* gameLayer;
//@property HUDLayer* hudLayer;

+(GameLayer*) sharedGameLayer;

@end
