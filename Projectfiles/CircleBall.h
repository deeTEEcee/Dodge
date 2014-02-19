/* this ball shoots out from any random direction but targets the center in a weird concentric manner AND then
targets the player after
 */
#import "Ball.h"

@interface CircleBall : Ball {
    bool aimAtTarget;
    bool moveClockwise;
}

@end
