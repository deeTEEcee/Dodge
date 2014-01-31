TODO:
- add score to the game scene and high score
- add a reset-score and yes/no are you sure option
- add timer to keep track of the score
- add sounds as the balls pop out
- add the sound when i get hit

- look at sample code that can show me a good way to decouple the HUD and the game layer while updating everything

- add the fastballs (they can only come from the farther side of the screen)
- start adding "how the level progresses over time" but only with the regular and fastballs right now.. BUT, think about the new balls also so we can easily add those later on

- add animation and a background (a grassy background? those balls are actually baseballs?)
- need a running animation

EXTRA:
- add stamina pills and a stamina bar

Maths Learned:
- trigonometry, line equation with 2 points, slopes
- distance = rate*time applies

Cocos2D Learned:
- runScene or replaceScene always has to be a new scene (well, i guess when switching to intro or game scene, just create a new one since you don't really have to switch between those all the time)
- there is a push and pop scene as well but you probably use that for something like in-game scenes that like to do some animation or something
- use [[[CCDirector sharedDirector] scheduler] setTimeScale:?] to slow or speed up the time