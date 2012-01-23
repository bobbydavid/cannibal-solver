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

No person will ever vote for themselves to be eaten.

Food does not spoil.

If there is not enough food left for everyone to eat one whole meal,
they all share the remaining food equally (and start sharpening their
knives, since the next day will see another of them butchered and turned
into that day's dinner).

The last survivor dies when he or she runs out of food.

Weights must all be rounded to the nearest integer.

If a person is faced with the sitation where two candidates are equally
appealing to him, he will choose the heavier candidate to prolong the
time until the next death occurs.

If a person is faced with the situation where two candidates are equally
appealing *and* of equal weight, she will choose alphabetically.

Each player must have a unique name.

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


Guarantee of a Solution
-----------------------

For the purposes of a game like the Cannibal Problem involving multiple
greedy entities, a 'solution' is a set of moves of every player such
that no player would want to deviate from his or her own moves. For the
cannibal problem, a solution always exists and is unique.

We can trivially see a unique solution exists for one person (he dies) or
two people (the bigger one eats the smaller one, or both die in a tie).
This will be our base case. Now we will use induction.

Assume a unique solution exists for any set of N inhabitants. Now consider
a group of N + 1 inhabitants. Without loss of generality, let us consider
the situation from the perspective of only one of the N + 1 players, whom
we will call Joe.

Joe has N voting choices. Each choice will result in N survivors left on
the island. From our assumption, this means a unique solution exists as to
the order people will be eaten. Therefore Joe will be able to calculate
exactly how many days he will survive in the event that each inhabitant dies.
Joe will therefore be able to deterministically assign to each other survivor
a number that represents the number of days Joe will stay alive if that
person is eaten. As Joe is playing greedily, he will use these numbers
to decide his favorite person to eat, as well as any pairwise elections.

The same logic applies to every survivor in the set of N + 1 survivors,
meaning that each pairwise election has a determinate outcome. These
outcomes can be used to calculate the Smith set, which itself [must exist
and will be unique][1]. Thus, the N + 1 inhabitants also have a unique
solution of whom they will eat next.

Inductively, this means that any set of N inhabitants will have a unique
solution.

[1]: http://en.wikipedia.org/wiki/Smith_set


Input File Format
-----------------

The input file will be a passenger manifest, with person's name and
weight. Each person will be on their own line, with their weight
listed last on the line. Example:

    Phillip 164
    Oswald 130
    Oliver 212
    Paulina 149



Output Format
-------------

The output should appear on the screen showing the order of deaths that
occur on the island along with the day they occurred. The format should be:

    Day 1: Edoardo dies.
    Day 76: David dies.
    Day 128: Cory dies.
    Day 233: Bobby dies.
    Day 413: Alice dies.



