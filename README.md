# hasktyping
A typing game written in Haskell.
Score is calculated by taking the sum of the Levenshtein distance from the line given in the script
to the line entered in by the player and the truncated time taken to write and enter in a line in seconds,
then squaring that sum, and then multiplying it by -1.
The highest score you can get in this game is zero

Play by entering in `./Hasktyping` in the command line. For something of a tool assisted speedrun, try `cat script | ./Hasktyping`
