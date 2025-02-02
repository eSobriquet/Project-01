/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/
VAR hunger = 3
VAR health = 1


->memory
=== memory ===
You were on a cruise ship that sunk do to an explotion on board. You remeber flying off the side of the ship as our vision was filled with fire was now all water. Shorty after hitting the water you lose consciousness.
*[Wake up]->shore
-> END

=== shore ===
You wake from a crab pinching your face. You are on the shore of what appears to be a small island. There is a small forest in the center of the island. It would be best to focus on survival. need food, fire, shelter.
    {The crabs begin to run from you|Crabs scurry at your feet|The crabs do a small dance in your honor}
    Health: {get_health()}
    Hunger: {get_hunger()}
+[Head towards the forest]->tree_line
+[Search the shore]->search_shore
-> END
=== tree_line ===
In the tree line of the forest you see tall coconut trees, {not take_coconut: with coconuts.} {not take_tarp: Along with a large blue sheet that is entangled in the trees.}
Health: {get_health()}
    Hunger: {get_hunger()}
+[Inspect the coconut tree]->tree
+{not take_tarp}[Inspect the blue sheet]->tarp
*{take_coconut}{hunger<3}[Try to open coconut]->open_coconut
+{take_coconut}{hunger>3}[Try to open coconut]->try_open_coconut
+[Venture into the forest]->forest
+[Go Back]->shore
*{take_tarp}{pickup_firewood}[Build shelter]->build_shelter
+{build_shelter}[Enter shelter]->shelter


-> END

=== search_shore ===
Not much on the shore. {not pickup_stones: You do manage to find some stones thgat may come in handy.}
Health: {get_health()}
    Hunger: {get_hunger()}
    *[Pickup stones]->pickup_stones
+[Go back]->shore
-> END
=== tarp  ===
The blue sheet is a large tarp that is entangled in the trees. Would be perfect to make shelter out of.
Health: {get_health()}
    Hunger: {get_hunger()}
    *{hunger==1}[Try and get the tarp]->take_tarp
    +{hunger>1}[Try and get the tarp]->try_take_tarp
-> END
=== try_take_tarp ===
Your body is too weak from hunger to get the tarp loose, should try and eat first.
->tree_line
-> END

=== take_tarp ===
You manage to get the tarp loose out of the trees, you now have a tarp.

    ->tree_line
-> END
=== tree ===
You walk up to the coconut tree it is taller than you first realized. You can attempt to climb the tree to get to the coconuts.
Health: {get_health()}
    Hunger: {get_hunger()}
     *{hunger<3}[Try to climb the tree]->take_coconut
    +{hunger>2}[Try to climb the tree]->try_take_coconut
-> END
=== try_take_coconut ===
while trying to climb the tree your weak muscles give out and you fall.
{damage()}
{health==0}->dead
->tree_line
-> END

=== take_coconut ===
You manage to get yourslef up the tree and grab the coconut
->tree_line
-> END
=== try_open_coconut ===
You bash it against a rock but are unable to get it open.

->tree_line
-> END

=== open_coconut ===
You manage to open it by bashing it against a rock. You eat it feeling nurished.
{eat()}
    ->tree_line
-> END
=== forest ===
Trees almost block the sun completely. Might be able to scavenge some food in here, and some wood for a fire and shelter. 
Health: {get_health()}
    Hunger: {get_hunger()}
    +[Scavenge for food]->berries
    *[Collect wood]->pickup_firewood
    +[Go back]->tree_line
-> END
=== berries ===
You find to sets of berry bushes. One has red berries and the other has purple ones.
*[Eat the red ones]->red_b
*[Eat the purple ones]->purp_b
+[Go back]->forest
->END
=== red_b ===
These berries taste sweet and refreshing.
{eat()}
->forest
-> END
=== purp_b ===
These barries are bitter and you start to feel odd, as if youve been poisoned.
{damage()}
{health==0}->dead
->forest
-> END


=== pickup_firewood ===
You collect the wood along the forest floor.
    ->forest
-> END
=== pickup_stones ===
You pick up the stones

    ->shore
-> END
=== build_shelter ===
You build a shelter out of sticks and the tarp.
->shelter
-> END
=== shelter ===
Its getting rather cold, best make a fire before sleeping.
+{not lit_fire}[Build fire]->build_fire
*{lit_fire}->sleep
+[Go Back]->tree_line
-> END

=== build_fire ===
you use firewood to make a small bundle for a fire. Need to find a way to light it.
+[Go back]->shelter
*[light the fire]->lit_fire
*{lit_fire}[Sleep]->sleep

-> END
=== lit_fire ===
You crash the stone together till you manage to get a spark going. You have made fire.
->shelter
-> END

=== sleep ===
You go to sleep hoping rescue will come for you soon.
-> END




=== function eat ===
~hunger= hunger-1
~health=health+1


=== function damage ===
~health= health-1

=== function get_hunger ===
{
-hunger==3:
~return "Starving"
-hunger==2:
~return "Hungry"
-hunger==1:
~return "Full"
-hunger==0:
~return "Stuffed"
}
=== function get_health ===
{
-health==0:
~return "Dead"
-health==1:
~return "Severe Injuries"
-health==2:
~return "Hurting"
-health==3:
~return "Healthy"
}
=== dead ===
You have died. Better luck next time.
-> END





