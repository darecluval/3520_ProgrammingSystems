SDE2 - July 29th, 2019
Clare DuVal
CPSC 3520

Pledge:
On my honor I have neither given nor received aid on this exam.

File One: nnr1.pro
  This file is written in Prolog and holds the specified and auxiliary functions for SDE1.

  Specified functions include:
    - printList: Prints a list of lists
    - theClass: Determines the class of a point from a list
    - distanceR2: Calculates the distance squared between two points
    - distanceAllVectors2: Creates a list of distances squared between a point in the form
      of a list and a list of points in the form of a list of lists
    - nnr1: Determines the class of the 1st nearest point determined from the least number
      found in a list created from distanceAllVectors2

  Auxiliary functions include:
    - prepend: Creates a float list by recursively prepending to the front
    - least: Finds the minimum value in a float list
    - find: Finds the index of a given float in a float list
    - getIDX: Returns the list at an index in a list of lists

  Built in Functions Used:
    - min: Returns minimum number of two input numbers
    - float: Turns an int/float argument to a float
    - write: Prints to the terminal
    - nth0: Returns the element of a list at a given index

File Two: nnr1.log
  This file is an ASCII log file showing 2 sample uses of each of the specified
  functions in nnr1.pro made by saving the terminal output of swi-prolog.

File Three: readme.txt
  This file contains a list of files and (if applicable) the intended use of each
  function in a given function.
