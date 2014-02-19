/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"
#import "GameManager.h"
#import "Global.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
    /* configuration */
    //    [[[CCDirector sharedDirector ] scheduler] setTimeScale:0.5];
    [[CCDirector sharedDirector] setDisplayStats:NO];
    
    WIN_SIZE = [[CCDirector sharedDirector] winSize];
    /* Run the scene */
    [[CCDirector sharedDirector] runWithScene:((CCScene*)[[GameManager sharedManager] newIntroScene])];
}

-(id) alternateView
{
	return nil;
}

@end
