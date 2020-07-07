# Critters and Croquettes: Day 6

>That night, you go to bed tired but feeling good about your use of inhertance to better define how critter objects can be created in your system. You sleep deeply and soundly, until just before sunrise, that is. That's when a terrible dream creeps in and disturbs your slumber.
>
>In the nightmare you are not a hotshot web app developer -- you are the newest intern at Critters and Croquettes Petting Zoo and Tapas Bar. And you have been assigned every job on the premises. One secord you're refilling the Critter Mix dispensers, the next you're scrubbing burned-on albondigas from a mountain of baking pans. Then suddenly you're faced with adding dozens of new animals to the habitats. Like a modern-day Noah, they keep coming and you keep having to find a place to put them all. And they're coming too fast. You can't keep up!
>
>In your panicked state you make a mistake, then another and another. The aviary ends up with a dozen bewildered hedgehogs in it; children cry as the petting zoo is overrun by rattlesnakes and copperheads; the snake pit is in chaos from an all-out battle between a flock of herons and the resident water snakes. 
>
>The shadow of Bobby Andrew Kawlins falls on you...
>
>You bolt awake, covered in a cold sweat. As you sigh in relief that it was all just a dream, you realize something almost as scary: it could really happen! 
>
>You decide that you'll need to add a check to the `addAnimal` method of your attractions classes to make sure a critter belongs in the attraction you're adding it to. Luckily, you already have a built-in way of determining what kind of critter you're dealing with.

```py
if animal.slithering:
  self.animals.push(animal)
```

## Practice: Birds of a Feather, Snakes of a Scale?
1. Refactor your critter instances to declare their particular distinguishing property of `slithering`, `flying` or `fuzzy`.
2. Refactor your attraction classes to check for the proper property before allowing the critter object to be added to its `animal` list.
3. Try adding a flying critter to a petting zoo's animals. What happens? If you get no feedback, the answer isn't "nothing". _Something_ happened, but maybe you didn't write any logic to provide the feedback you need, whether the result is positive or negative. Even on the command line, with no browser in sight, letting the user know what just happened is always a good idea. 


## Déjà Zoo
>There it is again. That feeling that you've coded down this path before. It's those attractions classes. They're all so...alike. And what happens when Bobby announces he's adding a "Monkey Island" or "Big Kat Kountry"? The problem will get worse. Sounds like it's time to get that inheritance train rolling again. But this time, you're going to bring out the big guns. 
>
WHAT WILL OUR HERO DO NEXT? FIND OUT IN THE NEXT THRIILING CHAPTER IN THE CRITTERS AND CROQUETTES SAGA! (But first, commit and push up your damn code)
