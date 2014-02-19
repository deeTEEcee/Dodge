TODO:
- fix target and the act of running an action
- test custom function in action (see if we can do an infinite loop in there and everything will still run smoothly...)
- redefine some of the code (what to inherit and the functionality needs to be encapsulated in the ball class)
- add the fastballs (they can only come from the farther side of the screen)
- add circle-delay balls (for now, they 30-70 either slowly move at you and when they are halfway make a random circular path (could be a full circle or only partial( and then target you again OR they just do what regular balls do


- add sounds as the balls pop out
- add the sound when i get hit

- start adding "how the level progresses over time" but only with the regular and fastballs right now.. BUT, think about the new balls also so we can easily add those laasasZter on

- add animation and a background (a grassy background? those balls are actually baseballs?)
- need a running animation
- look at sample code that can show me a good way to decouple the HUD and the game layer while updating everything

TODO maybe:
- add a reset-score and yes/no are you sure option
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