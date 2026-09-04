# mouseClickGame

A first-year coursework project built in Java using the Processing framework.
The player scores points by clicking enemies before they reach the goal zone, while avoiding moving obstacles that reduce health.
Difficulty scales dynamically as the score increases, spawning additional enemies over time.
Implements object-oriented design with separate classes for Enemy, Goal, and Obstacle entities, custom collision detection, and a persistent high-score system that reads/writes to a local file and maintains a sorted top-5 leaderboard using a custom insertion algorithm.
