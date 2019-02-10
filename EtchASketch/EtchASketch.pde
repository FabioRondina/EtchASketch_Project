/* Etch a Sketch */
/*
 Team - 2
 Project - Etch a Sketch
 Members:
   Liam Clifford - 1713749
   Fabio Rondina - 1707082
   Ramsus Tolonen - 1704632  
*/

import processing.serial.*;

//Declare all of our variables
int thicknessOptions = 0;                        //Sets the value for the line weight(1/2/3 = 1px/2px/3px)
boolean clearing = false;                        //Sets a boolean value to check if screen is cleaning (true) or not (false) 
boolean allowMove = true;                        //Sets a boolean value to check if the user is allowed to move (true) or not (false)

int lineX1 = 400;                                //The lines X position
int lineX2 = 400;
int lineY1 = 400;                                //The lines Y position
int lineY2 = 400;

int[] colArray = {#ff0000, #00ff00, #0000ff};        //Array of all colour codes - Red, Green, Blue
int colCounter = 1;                                  //Used to cycle through each of the colour options
int lineCol = #ff0000;                               //The lines initial colour - Red
String[] displayColArray = {"Red", "Green", "Blue"}; //Text version of the colArray
String displayCol = "";                              //A empty string to be used to display the colour string

int[] lineWeightArray = {1, 3, 6};                  //Array of all line weight options - 1px, 3px, 6px
int lineCounter = 1;                                //Used to cycle through each of the line weight options
int lineThick = 1;                                  //The lines current stroke weight

int borderColour = #ff0000;                         //The colour of the screens border

int screenBorderN = 50;    //The screens border limit on the north side
int screenBorderS = 750;   //The screens border limit on the south side
int screenBorderW = 50;    //The screens border limit on the west side
int screenBorderE = 750;   //The screens border limit on the east side

//Sets a message counter so we only print a message once - Used for each direction
int messageCounterN = 0;
int messageCounterS = 0;
int messageCounterW = 0;
int messageCounterE = 0;

Serial port;
String portContents = "";

void setup() {
  size(800, 800);                  //Window size
  background(150);                 //Background colour
  drawBorder();                    //Run the drawBorder function
  displayCol = displayColArray[0]; //Set the displayCol string to be the first element of the displayColArray

  port = new Serial(this, Serial.list()[1], 9600);   //Check the com port for the Arduino
  port.bufferUntil('\n');
}

void draw() {
  drawBorder();    //Run the drawBorder function
  
  //Draws a rectangle over the top bar and writes the "Etch a Sketch" text again to avoid "smudging" the text by redrawing it over and over again
  stroke( borderColour );
  noStroke();
  fill( borderColour );
  rect(50, 0, 750, 50);  //x,y,w,h

  textSize(24);
  fill(255);  
  textAlign(CENTER);
  text("Etch a Sketch", width/2, 30);

  //Draws a small rectangle over the whole previous bottom bar and writes all the information again to avoid "smudging" the text by redrawing it over and over again
  /*  Used for testing and development modes
  stroke( borderColour );
  noStroke();
  fill( borderColour );
  rect(50, 750, 750, 30);  //x,y,w,h

  fill(255);
  textSize(16);
  textAlign(LEFT);
  text("Colour selected - " + displayCol, 50, 775);

  textSize(16);
  textAlign(RIGHT);
  text("Line thickness selected - " + lineThick, 750, 775);
  */

  //Sets the base variables for each drawing, allowing line movement and line weight and colours
  strokeWeight(lineThick);
  stroke(lineCol);
  line(lineX1, lineY1, lineX2, lineY2);
}//End draw



void drawBorder() {  //Draws a red border around the screen on all 4 sides
  strokeWeight(1);
  fill( borderColour );
  stroke( borderColour );
  rect(0, 0, 800, 50);
  rect(0, 0, 50, 800);
  rect(750, 0, 50, 800);
  rect(0, 750, 800, 50);
}//End drawBorder



//Keyboard Input - Used for testing and development modes
/*
void keyPressed() {
  //Line Movement
  if ( (keyPressed == true) && ((key == 'w') || (key == 'W')) && (lineY1 > screenBorderN + 8) ) {   //Up
    lineY1 --;
    lineY2 --;
    messageCounterS = 0;
    messageCounterW = 0;
    messageCounterE = 0;
    messageCounterN++;
    
    if ( messageCounterN == 1 ) {
      println("Drawing up!");
    }//End if
    
  } else if ( (keyPressed == true) && ((key == 's') || (key == 'S')) && (lineY1 < screenBorderS - 8) ) {   //Down
    lineY1 ++;
    lineY2 ++;
    messageCounterN = 0;
    messageCounterW = 0;
    messageCounterE = 0;
    messageCounterS++;
    
    if ( messageCounterS == 1 ) {
      println("Drawing down!");
    }//End if
    
  } else if ( (keyPressed == true) && ((key == 'a') || (key == 'A')) && (lineX1 > screenBorderW + 8) ) {   //Left
    lineX1 --;
    lineX2 --;
    messageCounterN = 0;
    messageCounterS = 0;
    messageCounterE = 0;
    messageCounterW++;
    if ( messageCounterW == 1 ) {
      println("Drawing left!");
    }//End if
  } else if ( (keyPressed == true) && ((key == 'd') || (key == 'D')) && (lineX2 < screenBorderE - 8) ) {   //Right
    lineX1 ++;
    lineX2 ++;
    messageCounterN = 0;
    messageCounterS = 0;
    messageCounterW = 0;
    messageCounterE++;
    if ( messageCounterE == 1 ) {
      println("Drawing right!");
    }//End if
  }//End if



  //Clear Screen
  if ( (keyPressed == true) && ((key == 'c') || (key == 'C'))) {   //Checks if the user has pressed the key 'c'
    background(150);        //Redraws the windows background colour
  
    lineCol = #ff0000;      //Resets the lines colour
    lineThick = 1;          //Resets the lines weight
    displayCol = displayColArray[0];
  }//End if

  //Line Colour
  if ( (keyPressed == true) && ((key == 't') || (key == 'T')) ) {//Check if the key 't' has been pressed

    if ( colCounter == 0 ) {//Check if the counter is at 0, if so set line colour to element 0 of the colour array - colArray
      //lineCol = #ff0000;
      lineCol = colArray[0];
      displayCol = displayColArray[0];
      println("Line colour = Red");
      redraw();
    } else if ( colCounter == 1 ) {//Check if the counter is at 1, if so set line colour to element 1 of the colour array - colArray
      //lineCol = #00ff00;
      lineCol = colArray[1];
      displayCol = displayColArray[1];
      println("Line colour = Green");
      redraw();
    } else if ( colCounter == 2 ) {//Check if the counter is at 2, if so set line colour to element 2 of the colour array - colArray
      //lineCol = #0000ff;
      lineCol = colArray[2];
      displayCol = displayColArray[2];
      println("Line colour = Blue");
      redraw();
    }//End if
    colCounter++;//Increase the value of colCounter each press of the letter 't'

    if ( colCounter == 3 ) {//Counter reseter. Resets the value of colCounter so the user can cycle throuth the colour options again
      colCounter = 0;
    }
  }//End if

  //Line weight
  if ( (keyPressed == true) && ((key == 'g') || (key == 'g')) ) {        //Check if the key 'g' has been pressed

    if ( lineCounter == 0 ) {                                            //Check if the counter is at 0, if so set line weight to element 0 of the line weight array - lineWeightArray
      //lineThick = 1;
      lineThick = lineWeightArray[0];
      println("Line weight = 1");
    } else if ( lineCounter == 1 ) {                                     //Check if the counter is at 1, if so set line weight to element 0 of the line weight array - lineWeightArray
      //lineThick = 3;
      lineThick = lineWeightArray[1];
      println("Line weight = 3");
    } else if ( lineCounter == 2 ) {                                     //Check if the counter is at 2, if so set line weight to element 0 of the line weight array - lineWeightArray
      //lineThick = 6;
      lineThick = lineWeightArray[2];
      println("Line weight = 6");
    }//End if
    lineCounter++;                                                      //Increase the value of lineCounter each press of the letter 'g'

    if ( lineCounter == 3 ) {                                            //Counter reseter. Resets the value of lineCounter so the user can cycle throuth the weight options again
      lineCounter = 0;
    }//End if
  }//End if
}//End keyPressed()
*/



void serialEvent(Serial readPort) {              //Used to read input from the Arduino
  portContents = readPort.readStringUntil('\n');

  if ( portContents != null ) {                  //Check if there is anything being sent over the port
    portContents = trim( portContents );
  }//End if

  //Line colour
  if ( portContents.equals( "y" ) ) {  //Check if the yellow button has been pressed on the Arduino

    if ( colCounter == 0 ) {           //Check if the counter is at 0
      //lineCol = #ff0000;             //Testing - Declare the colour exactly
      lineCol = colArray[0];           //Set the line colour to element 0 of the colour array
      displayCol = displayColArray[0]; //Set the string to display the first element of the displayColArray
      println("Line colour = Red");    //Print to the console that the line has been set to red
      redraw();                        //Run the redraw method
      
    } else if ( colCounter == 1 ) {    //Check if the counter is at 1
      //lineCol = #00ff00;             //Testing - Declare the colour exactly  
      lineCol = colArray[1];           //Set the line colour to element 1 of the colour array
      displayCol = displayColArray[1]; //Set the string to display element 1 of the displayColArray
      println("Line colour = Green");  //Print to the console that the line has been set to green
      redraw();                        //Run the redraw method
      
    } else if ( colCounter == 2 ) {    //Check if the counter is at 2
      //lineCol = #0000ff;             //Testing - Declare the colour exactly
      lineCol = colArray[2];           //Set the line colour to element 2 of the colour array
      displayCol = displayColArray[2]; //Set the string to display element 2 of the displayColArray
      println("Line colour = Blue");   //Print to the console that the line has been set to blue
      redraw();                        //Run the redraw method
    }//End if
    colCounter++;                      //Increase the value of colCounter each press of the letter 't'

    if ( colCounter == 3 ) {           //Checks if the colCounter value is at 3
      colCounter = 0;                  //Resets the value of colCounter so the user can cycle throuth the colour options again
    }//End if
  }//End portContents if

  //Line weight
  if( portContents.equals( "g" ) ) {  //Check if the grey button has been pressed on the Arduino

    if ( lineCounter == 0 ) {         //Check if the counter is at 0
      //lineThick = 1;                //Testing - set the line weight directly
      lineThick = lineWeightArray[0]; //Set line thickness to the first element of the lineWeightArray
      println("Line weight = 1");     //Print to the console the line weight
      
    } else if ( lineCounter == 1 ) {  //Check if the counter is at 1
      //lineThick = 3;                //Testing - set the line weight directly
      lineThick = lineWeightArray[1]; //Set the line thickness to element 1 of the lineWeightArray
      println("Line weight = 3");     //Print to the console the line weight
      
    } else if ( lineCounter == 2 ) {  //Check if the counter is at 2
      //lineThick = 6;                //Testing - set the line weight directly
      lineThick = lineWeightArray[2]; //Set the line weight to element 2 of the lineWeightArray
      println("Line weight = 6");     //Print to the console the line weight
    }//End if
    lineCounter++;                    //Increase the value of lineCounter each press of the letter 'g'

    if ( lineCounter == 3 ) {         //Check if the lineCounter value is at 3
      lineCounter = 0;                //Resets the value of lineCounter so the user can cycle throuth the weight options again
    }//End if
  }//End portContents if
  
  //Clear the screen
  if( portContents.equals( "b" )) {  //Checks if the blue button was pressed on the Arduino
    background(150);                 //Redraws the windows background colour
    lineCol = #ff0000;               //Resets the lines colour
    lineThick = 1;                   //Resets the lines weight
    displayCol = displayColArray[0]; //Resets the displayCol element to 0
  }//End portContents if
  
  
  //Potentiometer control
  if ( (portContents.equals( "u" )) && (lineY1 > screenBorderN + 8) ) {   //If the Arduino has sent the character "u"
    lineY1 --;                      //Decrease the lineY1 value
    lineY2 --;                      //Decrease the lineY2 value
    messageCounterS = 0;            //Sets the counter value to 0
    messageCounterW = 0;            //Sets the counter value to 0
    messageCounterE = 0;            //Sets the counter value to 0
    messageCounterN++;              //Increases the counter value
    
    if ( messageCounterN == 1 ) {   //Checks if the counter value is set to 1
      println("Drawing up!");       //Print a message to the console saying the line is going up
    }//End if
  } else if (( portContents.equals( "d" )) && (lineY1 < screenBorderS - 8) ) {   //If the Arduino has sent the character "d"
    lineY1 ++;                      //Increase the lineY1 value
    lineY2 ++;                      //Increase the lineY2 value
    messageCounterN = 0;            //Sets the counter value to 0
    messageCounterW = 0;            //Sets the counter value to 0
    messageCounterE = 0;            //Sets the counter value to 0
    messageCounterS++;              //Increases the counter value
    
    if ( messageCounterS == 1 ) {   //Checks if the counter value is set to 1
      println("Drawing down!");     //Prints a message to the console saying the line is going down
    }//End if
  } else if (( portContents.equals( "l" )) && (lineX1 > screenBorderW + 8) ) {   //If the Arduino has sent the character "l"
    lineX1 --;                      //Decrease the lineX1 value
    lineX2 --;                      //Decrease the line X2 value
    messageCounterN = 0;            //Sets the counter value to 0
    messageCounterS = 0;            //Sets the counter value to 0
    messageCounterE = 0;            //Sets the counter value to 0
    messageCounterW++;              //Increases the counter value
    
    if ( messageCounterW == 1 ) {   //Checks if the counter value is set to 1
      println("Drawing left!");     //Prints a message to the console saying the line is going left
    }//End if
  } else if (( portContents.equals( "r" )) && (lineX2 < screenBorderE - 8) ) {   //If the Arduino has sent the character "r"
    lineX1 ++;                      //Increase the lineX1 value
    lineX2 ++;                      //Increase the lineX2 value
    messageCounterN = 0;            //Sets the counter value to 0
    messageCounterS = 0;            //Sets the counter value to 0
    messageCounterW = 0;            //Sets the counter value to 0
    messageCounterE++;              //Increases the counter value
    
    if ( messageCounterE == 1 ) {   //Checks if the counter value is set to 1
      println("Drawing right!");    //Prints a message to the console saying the line is going right
    }//End if
  }//End if - portContents
}//End serialEvent