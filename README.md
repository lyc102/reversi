This is the game Reversi. For the rules on this game, please check https://en.wikipedia.org/wiki/Reversi

Click outside of the board to pass. 

The stone state is given by the 8 x 8 matrix u.  Values  
0: empty;   1: black;   -1: white

- Run Reversi.m to play the game 
- Run ReversiAI.m to play the game with AIs
  - easy.  AI random
  - medium.  AI position value
  - medium hard.  AI tree search (two steps)
  - hard but slow.  AI tree search (depth > 2)
  - hard and fast.  AI tree search with top N pruning
  - harder and slow. AI MCTS (Monte Carlo tree search)

uncomment the corresponding subroutine to play with different AIs.
