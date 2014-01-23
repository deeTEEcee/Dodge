TODO:
- add score to the game layer
- add timer to keep track of the score
- add sounds as the balls pop out
- add the sound when i get hit

Maths Learned:
- trigonometry, line equation with 2 points, slopes
- distance = rate*time applies

Cocos2D Learned:
- runScene or replaceScene always has to be a new scene (well, i guess when switching to intro or game scene, just create a new one since you don't really have to switch between those all the time)
- there is a push and pop scene as well but you probably use that for something like in-game scenes that like to do some animation or something
- use [[[CCDirector sharedDirector] scheduler] setTimeScale:?] to slow or speed up the time