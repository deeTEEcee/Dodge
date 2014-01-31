/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"
#import "GameManager.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
    GameManager* gm = [[GameManager alloc] init]; // code-wise, you should put this in some [GameManager getSingleton]
    [[CCDirector sharedDirector] runWithScene:[GameManager sharedIntroScene]];
    /* configuration */
    [[CCDirector sharedDirector] setDisplayStats:NO];
//    [[[CCDirector sharedDirector ] scheduler] setTimeScale:0.5];
}

-(id) alternateView
{
	return nil;
}

@end
