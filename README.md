# Calculator
A reverse polish notation calculator that demonstrates auto layout, stacks, target-actions on UIButtons

## Step 0: Setup Window (non-storyboard version)

- In the ```application:didFinishLaunchingWithOptions:```

 - Allocate memory and instantiate the ```AppDelegate```'s ```window```
 - set ```self.window.background``` to white
 - set the ```window```'s ```rootViewController```
 - call ```[self.window makeKeyAndVisible] 

## Step 1: Add displayLabel to the view

- create a property of a label called ```displayLabel``` and add it to the view
- set the text alignment of ```displayLabel``` to right
- set the font to size 32
- set the text to ```@"0"```

## Step 2: Add constraints to the displayLabel

- center the ```displayLabel``` and have it go across the top of the view
- set the height of the ```displayLabel``` to 50.
- don't forget to ```setTranslatesAutoresizingMaskIntoConstraints``` to ```NO```.

## Step 3: Add buttons and constraints

- Your buttons should look like this:
	- equal heights for all buttons
	- equal width for all buttons (except enter, which should be twice as wide as other buttons)
	- buttons should be below the display text
	- buttons should take up rest of screen
	- should resize nicely when device rotated



```[7][8][9][/]
[4][5][6][*]
[1][2][3][-]
[0][Enter][+]```







