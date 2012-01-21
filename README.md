Cannibal Problem
================

The cannibal problem is the following: imagine you and a group of your
friends are shipwrecked on a desert island.  Nobody is sure when -- or
if -- help will arrive.  As your supplies start to dwindle, you realize
you will be forced into cannibalism to survive. The question is, who
will the group decide to eat?

Obviously nobody wants to be the next meal. Therefore, you will need to
out-muscle the victim if you want to eat him. For your purposes, you will
only be able to "out-muscle" and eat another island inhabitant if you
outweigh him, or if you can cobble together a coalition of hungry people
who outweigh your target and all agree to kill him.

However, nobody wants to appear bloodthirsty, so there are some restrictions.
You and your fellow island dwellers are not monsters --- you will only
kill a fellow islander if you are completely out of food. Once killed
and butchered, that inhabitant yields one meal for every pound they weigh.

So how does the group decide the next victim? By voting! Every resident
of the island votes for who they'd most like to eat, and majority rules
(remember, that's majority determined by weight, not by votes). If there
is no clear majority, than things get complicated. The residents will
conduct run-off elections between every candidate and determine the
[Smith set](http://en.wikipedia.org/wiki/Smith_set), i.e. the smallest
set of candidates where any candidate in the set would "win" against
any candidate outside the set in a runoff election. These finalists
all fight each other in a glorious battle royale until someone dies.
Inevitabily, it is the lightest one(s) who die in the battle royale.

To solve the cannibal problem, you must determine the order in which
each island inhabitant is eaten and the day that the last survivor
dies.


Additional Notes
----------------

Food does not spoil.

If there is not enough food left for everyone to eat one whole meal,
they all share the remaining food equally (and start sharpening their
knives, since the next day will see another of them butchered and turned
into that day's dinner).

The last survivor dies when he or she runs out of food.

Weights must all be rounded to the nearest integer.

Example Scenarios
-----------------

**David and Goliath:**

David and Goliath are shipwrecked, each weighing 130 and 240 pounds,
respectively. They "vote" each other to be eaten, but Goliath weighs
more so he wins the vote. Goliath butchers David and survives for an
additional 130 days.


**Goldilocks gets it easy**

The three bears from the Goldilocks tale are stranded on the island.
Papa weighs 350 pounds, Mama weighs 310 pounds, and Baby weighs 180
pounds. Baby knows that no matter who gets eaten first, he will be
eaten second. Therefore, he votes to eat Papa first to survive as long
as possible. Mama knows that Papa will eat her second if they eat
Baby first, so she also votes to eat Papa. Papa votes to eat Baby
but is outvoted by 490 pounds to 350. Mama and Baby feast on Papa for
175 days. Then, Mama eats Baby and survives another 180 days. Total
survival time: 355 days.


Input File Format
-----------------

The input file will be a passenger manifest, with person's name and
weight. Each person will be on their own line, with their weight
listed last on the line. Example:

    Phillip 164
    Oswald 130
    Oliver 212
    Paulina 149


