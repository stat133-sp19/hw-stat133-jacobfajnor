Data Dictionary
================

This document provides information on the data categories and data types within the Golden State Warriors project.

## Data categories:

1.  **team\_name** - the name of the NBA team that each player plays for.

2.  **game\_date** - the day the game was played that the shot data was recorded at.

3.  **season** - the year that the games were played

4.  **period** - an NBA game is divided into 4 period of 12 mins each. For example, a value of period = 1 refers to the first 12 mins of the game.

5.  **minutes\_remaining** and **seconds\_remianing** - the ammount of time left in the period. Thus a shot taken in period 1 with 1 minute\_remaining and 30 seconds\_remaing would be a shot taken 10 minutes and 30 seconds into the game.

6.  **shot\_made\_flag** - whether or not the shot was made

7.  **action\_types** - has to do with the basketball moves used by the players, either to pass by defenders to gain access to the basket, or to get a clean pass to a teamate to score a two pointer or three pointer.

8.  shot\_type - two point field goal or three point field goal.

9.  shot\_distance - straightline distance to the basket from where the shot was taken (measured in feet).

10. **x** and **y** - refer to court coordinates (in inches) where a shot occured.

11. **Opponenet** - the team the player scored against

12. **name** - the player's name

13. **minute** - the minute of the game when the point was scored. Calculated by (period \* 12) - minutes\_remaining.
