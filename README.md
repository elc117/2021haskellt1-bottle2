# SpiroStudio: the Haskell Clone

Look at [this](https://www.kongregate.com/games/polycube/spirostudio)! Oh wait.
Flash is dead. RIP. Anywho, SSHC is an attempt to reimplemented it... or part of
it.

## What is this

This is a little program inspired on SpiroStudio that generates spirographs.

## Running

Consider we have the following file:

    $ cat spiro.txt
    500.0
    500.0
    68.0
    17.0
    51.0
    17.0
    68.0
    -3.0
    34.0
    -3.0
    17.0
    17.0

The first and the second line specifies the width and the height of the SVG.
Five sticks are used to draw the spirographs, so each two pairs of lines that
follows specifies the length and the speed of each stick. All lengths and speeds
of all five sticks must be specified.

Next, to generate a spirograph you run:

    $ stack runghc Main.hs < spiro.txt > spiro.svg

Main.hs reads the content of spiro.txt, which output is saved on spiro.svg

You could use ImageMagick to convert SVG to PNG:

    $ convert spiro.svg spiro.png

## Kongregate comments detailing SpiroStudio's inner working

Developer response to AceFrahm on Dec. 1, 2013:

    The length of each stick is calculated by generating a random number between
    1 and 8 and multiplying that by 8. The lengths are then scaled so that the
    total adds up to 240, so the pattern doesn't end up being too big or small.


MJMKing commented on Dec. 7, 2013:

    I meant, why do the arms stop drawing after a period of time, even if the
    drawing isn't complete (i.e. the arms aren't stopping at the starting
    point)?

To which the developer responded:

    I put a limit on how much drawing it can do, since too much drawing can
    cause performance to drop and make the interface unresponsive. But I've
    increased the limit in the new version that's up now, so you should be able
    to make patterns that are quite a bit longer than before.


fil03 said on Dec. 18, 2013:

    This system is based on a 720 point scale. For example : 1 2 3 4 5 is the
    exact same as: 721 722 723 724 725. Try it if you're skeptical. Normally,
    these tools are based on a 360 point scale, but for this, try: 361 362 363
    364 365. At 361, the line appears exactly the same as it does with 1, but it
    oscillates 180 degrees every turn, which is why its all pointy. The #
    represents how many degrees it rotates per frame, up to 720, which as stated
    is when it loops back.  At 360, the processor has it going all the way
    around, and it creates a spot 180 degrees off. + this so others can
    understand what they are doing.


Tecnoturc asked on Dec. 6, 2013:

    This is great for what it is. I wouldn't necessarily call this a game
    though. As a teacher, I'm trying to imagine how I could use this in the
    classroom.. help me out? I would like to put this tool to good use! What was
    the purpose of creating this anyways?

To which the developer responded:

    It started out as a generative art experiment that turned out to have more
    depth than I expected. What makes it interesting is that the math is very
    simple, but it has nice emergent properties. So I guess the most obvious way
    to use this would be to help with visualizing parametric equations. Each
    stick uses these equations to calculate its relative x and y (t is the
    parameter):

	X = sin(speed * t + phase) * length, Y = cos(speed * t + phase) * length

    And then all the positions are added together to produce the end result.
    Hope that helps.
