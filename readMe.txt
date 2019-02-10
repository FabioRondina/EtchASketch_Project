Etch a Sketch!

***********************************************

Authors:
Liam Clifford
Rasmus Tolonen
Fabio Rondina

***********************************************

Descripton:
The Etch a Sketch program allows users to use an Arduino Uno board and the program Processing to draw lines on the screen like a real life Etch a Sketch.

***********************************************

Files:
Arduino_EtchASketch.ino
EtchASketch.pde
EtchASketch_Hardware_Test.ino

***********************************************

Tutorial:
You use the left potentiometer to control the line tool going left and right. If you place the potentiometer in the middle area to stop drawing the line.
You use the right potentiometer to control the line tool going up and down. Again placing the potentiometer in the middle area will stop drawing the line.
The yellow button will allow you to switch between the 3 line colour options: Red, green and blue.
The grey button will let you to switch between the 3 line weight options: 1, 3 and 6.
The blue button will allow the user to clear the screen allowing you to start again.

***********************************************

Testing:
Within the main processing code you will find a method for testing the program without needing the Arduino board. This uses keyboard input to control the lines, line colours/thickness and to clear the screen. There is also the option to show text on screen detailing the line colour and thickness option as you change them.
We have also included a separate Arduino program to allow you to test the Arduino Uno board and all subsequent components before you run the program.
Program is called - EtchASketch_Hardware_Test.ino
