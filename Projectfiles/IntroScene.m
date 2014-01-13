//
//  IntroScene.m
//  Dodge
//
//  Created by David Chen on 1/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "IntroLayer.h"


@implementation IntroScene

-(id) init{
    if(self=[super init]){
        IntroLayer* introLayer = [IntroLayer node];
        [self addChild:introLayer];
    }
    return self;
}
@end
