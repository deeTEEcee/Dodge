//
//  HUDLayer.m
//  Dodge
//
//  Created by David Chen on 1/29/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "GameScene.h"

@implementation HUDLayer

-(id) init{
    if(self = [super init]){
        self.scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Arial" fontSize:8];
        self.scoreLabel.position = ccp(5,5);
        [self.scoreLabel setAnchorPoint: ccp(0, 0.5f)]; // left align
        
        [self scheduleUpdate];
        
        [self addChild:self.scoreLabel];
    }
    return self;
}

-(void) update:(ccTime)delta{
    // constantly update the score with every change in time
    [self.scoreLabel setString:[NSString stringWithFormat:@"Score:%d", [GameScene sharedGameLayer].score]];
}


@end
