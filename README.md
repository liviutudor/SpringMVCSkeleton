SpringMVCSkeleton
=================

Creates a basic directory/file structure for a Maven/Spring MVC 3.0 Java project.

This project started from my own frustations encountered every time I had to create a new Spring MVC project as there seems to be no command-line which can create all the needed scaffolding quickly, hence this script. 

It is based on this tutorial on SpringSource: http://static.springsource.org/docs/Spring-MVC-step-by-step/ and it is just a glorified bash script. That is to say it won't work on Windows -- but hopefully we'll get some Windows power users to port this to a Windows cmd script?!

NOTE
-----
Big thanks to [Sean Wong](https://twitter.com/MovingDecoy "Sean Wong") for his pull request regarding using heredoc's and `mkdir -p`.
