To watch demo:
http://www.youtube.com/watch?v=oOO74rflqMI&feature=youtu.be

Note: I thought it would be easy to cross-platform but the documentation wasn't simple enough and there was no tutorial given that showed how Kobold2D would compare mouse inputs the same as touch inputs or some way to differentiate the mac vs. the ios when coding. (TLDR: didn't want to spend the time to figure it out when I need to do other stuff as well)


TODO:
- add the slowballs and fastballs (fastballs can only come from the farther side of the screen)

- start modifying "how the level progresses over time" but only with the regular and fastballs right now.. BUT, think about the new balls also so we can easily add those laasasZter on

TODO maybe:
- add a reset-score and yes/no are you sure option
- add animation and a background (a grassy background? those balls are actually baseballs?)
- need a running animation
- release the game and we could charge for different "themes" which just change the background and the ball elements

EXTRA:
- add stamina pills and a stamina bar

Maths Learned:
- trigonometry, line equation with 2 points, slopes
- distance = rate*time applies

ObjectiveC Learned:
- for private variables, maybe just add a p to naming sequence for the future (because they don't use self, only properties use that)

Cocos2D Learned:
- runScene or replaceScene always has to be a new scene (well, i guess when switching to intro or game scene, just create a new one since you don't really have to switch between those all the time)
- there is a push and pop scene as well but you probably use that for something like in-game scenes that like to do some animation or something
- use [[[CCDirector sharedDirector] scheduler] setTimeScale:?] to slow or speed up the time
- you can safely unschedule within the function being scheduled
- tried unscheduling the main update function when it's called via scheduleUpdate, IT DOES NOT UNSCHEDULE