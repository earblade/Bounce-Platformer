# Bounce-Platformer
First game made by myself. Simple game involving going up by bouncing on randomly generated platforms, the higher you go the higher score you get.

## Main Level
Where the guy starts on the ground and you press space to initially jump up onto a platform

### ver1
this branch uses the default gravity included with Godot.
had troubles trying to get the camera to work how I wanted with teleporting.

The teleport was because I wanted the game to randomly generate forever, but obviously you run into the problem where you go infinitely upwards.
The solution worked (minus the procedural gen), but I couldn't get the camera to not jiggle around the place when I teleported between the two.

The best solution for this was to manually change the offset of the new camera, however this runs into the issue where the camera will have to constantly change in a direction, eventually making the player seem outside of the camera and make it impossible to play. Hence, I'm stopping it here and am moving to implement ver2
