# Critters and Croquettes: Day 2

>You're feeling pretty good about your first steps to building what your new client, Bobby Kawlins, has hired you to create. You have a long list of critter classes ready to churn out as many goats, chickens and llamas as Bobby can stuff into his petting zoo. So, the next day you decide to drop by and give Bobby an update on your progress in person. 
>
> Bobby doesn't greet you as you pass through the tapas bar and step into the critter corral. You're about to go back inside and ask the staff where he might be when you realize that the high pitched wail you just heard wasn't one of the resident peacocks, but a child. The boy is sitting in the dust under the "Critter Mix" dispensers ( "Just 50 cents for a whole handful!"), crying inconsolably.
>
>Then you spot Bobby, patiently listening to an angry man vent his parental concern about the "life-threatening situation" you seem to have just missed witnessing in person.
>
>That's when you also notice the agitated goat, pacing back and forth and shaking his horns while an employee tries to distract it with a handful of Criter Mix. You start to put together what happened.
>
>Once the situation has been diffused with some free passes and a promise of a full refund, and the boy and father have headed inside to clean up, you sidle up to Bobby.
>
>"Goat: 1, Child: 0?" you smile. 
>
>Bobby turns with a look of surprise. "Oh, hey there, friend! Yeah, Norman over there decided he'd had enough ear-pulling for one day and asserted his genetic birthright to head-butt the offending tyke." 
>
>You're not sure whether to laugh or look serious. Luckily, Bobby fills the temporary awkward silence with a burst of his showman's energy.
>
>"I'm so glad you're here!", he exclaims. "I just had an idea for how to cut down on grumpy goats and angry alpacas! If I could have the animals available for petting in regular shifts, then I could give them scheduled breaks from all the poking and prodding. What do you say? Can you fix it so I can split my menagerie up into three groups? 
>
>"Nothing fancy, mind you. Just something like 'shift A', 'shift B', etc. Then I can rotate my cranky critters in and out and cut down on customer service issues like the one that just occurred."
>
>"No problem," you assure him. 

### Practice: Clocking in the Critters
It's time to update your collection of critter classes...again. 

##### *You are commiting your work, right? How about making a new branch for each Critters and Croquettes exercise? Of course you are! How silly of us to even bring it up*

This time, add a `shift` property to the classes that define animals in the petting zoo. Update the ones with the `walking` property only, since they're the only ones that will need a break from being mauled by toddlers. Don't forget to add a parameter to the __init__ method, too. When testing your changes, designate a critter's shift as 'morning', 'midday' or 'afternoon' when it is instantiated.

When finished, you should be able to do this
```py
roberto = Alpaca("Roberto", "alpaca", "midday")
print(f'{roberto.name} the {roberto.species} is available to pet during the {roberto.shift} shift.')
# prints Roberto the alpaca is available to pet during the midday shift.
```

> The day comes to an end, and you realize something is bugging you. You should feel good about helping Bobby solve his real-world problems, but when you look at your code it feels...off.
>
>It runs just fine, but you realize that you just spent an awful lot of time refactoring. You also have a sneaking suspicion that Bobby Kawlins isn't done having "great ideas."
>
>You decide you're just hungry and tired, and before you get the urge to head-butt your computer you decide to sleep on it.
