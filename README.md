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
is no clear majority, than things get complicated (see the voting section,
below).

To solve the cannibal problem, you must determine the order in which
each island inhabitant is eaten and the day that the last survivor
dies.


Voting Options
--------------

#### Naive Voting

Each living member of the community will vote to eat the person that
extends their own life the longest. Given two equal options, each
voter will prefer to vote for heavier people to prolong the time until
the next killing. If two or more people hold a plurality, than the
smallest person is killed. If there is a tie for the smallest, the
person who comes alphabetically first is killed.

Note that each player votes as if he had unilateral control for this round.
There are cases where it would be beneficial to vote for someone other than
one's ideal candidate. Naive voting ignores any such scenarios.


#### Candorcet Voting

The residents will
conduct run-off elections between every candidate and determine the
[Smith set](http://en.wikipedia.org/wiki/Smith_set), i.e. the smallest
set of candidates where any candidate in the set would "win" against
any candidate outside the set in a runoff election. These finalists
all fight each other in a glorious battle royale until someone dies.
Inevitabily, it is the lightest one(s) who die in the battle royale.


#### Mob Voting

Mob voting starts like naive voting, where each person votes to extend their
own life the longest. However, once that plurality is determined, the people
who are _not_ taking part in the killing have the opportunity to elect an
alternative victim. If they can form a larger plurality of the remaining
people, they can challenge and defeat the existing mob. After the skirmish,
the members of the beaten plurality are knocked out and can no longer
participate in voting for this round. This continues until no plurality can
be formed that can challenge the mob. If multiple groups can be created to
challenge the existing mob, we only consider the largest one.


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


**The Three Bears -- No Golidlocks**

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
Thus Joe, and anyone observing Joe, will be able to determine his voting
preferences.

At this point everyone knows everyone else's voting preferences. Without any
assumptions about the voting process, this could lead to unstable voting
scenarios. For instance, say Joe has two people he would most like to eat:
Daisy and Patsy. Bill also wants to eat either Daisy or Patsy. However,
what if it is in Bill's best interest to vote for the same person as Joe, but
in Joe's best interest to vote for a different person than Bill? Since they
each know that about each other, the situation devolves into an infinitely
rescursive guessing game.

To solve the problem, the voting system must not allow for these loops.
Naive voting is the easiest system that follows this principle: players always
vote for the person they would eat if they had unilateral control, which no
regard to how others might vote. Since voters disregard each other's
preferences, the system avoids any infinite loops. Other potential voting
schemes exist, but the important property of a viable scheme is that
the process must yield exactly one 'winner', even when considering that
voting is effectively not secret.

To sum up, our N + 1 survivors each have predictable personal preferences for
each vote, and our voting method guarantees that knowing the personal
preferences for each voter is enough to determine the outcome of the vote.
Therefore we can determine the outcome of the election where N + 1 survivors
are voting.

Inductively, this means that any set of N inhabitants will have a unique
solution to the Cannibal Problem.


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



