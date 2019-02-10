/* Etch a Sketch */
/*
  Team - 2
  Project - Etch a Sketch
  Members:
          Liam Clifford - 1713749
          Fabio Rondina - 1707082
          Ramsus Tolonen - 1704632  
*/
/*
  Movement:
    Potentiometer (Left):
      Pin - A0-D14
    Potentiometer (Right):
      Pin - A1-D15
      
  Clearing section:
    LED Yellow:
      Pin - 2
    LED Green:
      Pin - 3
    Button Blue:
      Pin - 4
      
  Line weight section:
    LED Red:
      Pin - 5
    LED Green:
      Pin - 6
    LED Yellow:
      Pin - 7
    Button Grey:
      Pin - 8
      
  Line Colour section:
    LED Red:
      Pin - 9
    LED Green:
      Pin - 10
    LED Blue:
      Pin - 11
    Button Yellow:
      Pin - 12
*/

byte colLightCount = 0;
byte weightLightCount = 0;
byte clearLightCount = 0;

void setup() {
  //Declare all our pins for the arduino components
  //Movement
  pinMode(A4, INPUT);       //Potentiometer (left):
  pinMode(A5, INPUT);       //Potentiometer (right):

  //Clearing
  pinMode(2, OUTPUT);       //Yellow LED
  pinMode(3, OUTPUT);       //Green LED
  pinMode(4, INPUT);        //Blue button

  //Line Weight
  pinMode(5, OUTPUT);       //Red LED
  pinMode(6, OUTPUT);       //Green LED
  pinMode(7, OUTPUT);       //Yellow button
  pinMode(8, INPUT);        //Grey button

  //Line Colour
  pinMode(9, OUTPUT);       //Blue LED
  pinMode(10, OUTPUT);      //Green LED
  pinMode(11, OUTPUT);      //Red LED
  pinMode(12, INPUT);       //Yellow button

  //Screen output
  Serial.begin(9600);       //Use the Arduino serial monitor

  //Activate the line colour/thickness LED's on startup
  digitalWrite(9, HIGH);    //Red
  digitalWrite(7, HIGH);    //Yellow

}//End setup

void loop() {
  //Change the line colours
  if( digitalRead(12) == HIGH ) { //Yellow button
    Serial.println("y");          //Send a string to the console to be read by Processing
    colLightCount++;              //Increase the line colour counter per button press
    
    if( colLightCount == 0 ) {
      digitalWrite(9, HIGH);      //Red LED
      digitalWrite(10, LOW);      //Green LED
      digitalWrite(11, LOW);      //Blue LED
    } else if( colLightCount == 1 ) {
      digitalWrite(9, LOW);       //Red LED
      digitalWrite(10, HIGH);     //Green LED
      digitalWrite(11, LOW);      //Blue LED
    } else if( colLightCount == 2 ) {
      digitalWrite(9, LOW);       //Red LED
      digitalWrite(10, LOW);      //Green LED
      digitalWrite(11, HIGH);     //Blue LED
    }//End if
    
    if( colLightCount == 2 ) {    //Resets colLightCount variable
      colLightCount = -1;         //Resets the value to -1 to allow the next button press to set the correct light
    }//End if
    delay(250);                   //Add a small delay per button press 
    
  }//End if - line colours

  //Change the line weight
  if( digitalRead(8) == HIGH ) {  //Grey button
    Serial.println("g");          //Send a string to the console to be read by Processing
    weightLightCount++;           //Increase the line weight counter per button press

    if( weightLightCount == 0 ) {
      digitalWrite(5, LOW);       //Red LED
      digitalWrite(6, LOW);       //Green LED
      digitalWrite(7, HIGH);      //Yellow LED
    } else if( weightLightCount == 1 ) {
      digitalWrite(5, LOW);       //Red LED
      digitalWrite(6, HIGH);      //Green LED
      digitalWrite(7, LOW);       //Yellow LED
    } else if( weightLightCount == 2 ) {
      digitalWrite(5, HIGH);      //Red LED
      digitalWrite(6, LOW);       //Green LED
      digitalWrite(7, LOW);       //Yellow LED
    }

    if( weightLightCount == 2 ) {  //Resets weightLightCount variable
      weightLightCount = -1;       //Resets the value to -1 to allow the next button press to set the correct light
    }//End if
    delay(250);                    //Adds a small delay per button press
    
  }//End if - line weight

  //Clear the screen
  if( digitalRead(4) == HIGH) {    //Blue button
    Serial.println( "b" );         //Send a string to the console to be read by processing
    digitalWrite(2, HIGH);         //Yellow LED is lit to show the program is clearing
    digitalWrite(3, LOW);          //Green LED
    
    //Reset the line colours: LED's and counter values
    colLightCount = -1;            //Line colour counter
    digitalWrite(9, HIGH);         //Red LED - Line colour
    digitalWrite(10, LOW);         //Green LED - Line colour
    digitalWrite(11, LOW);         //Blue LED - Line colour
    
    //Reset line weight: LED's and counter values
    weightLightCount = -1;         //Line weight counter
    digitalWrite(5, LOW);          //Red LED - Line weight
    digitalWrite(6, LOW);          //Green LED - Line weight
    digitalWrite(7, HIGH);         //Yellow LED - Line weight
  } else if( digitalRead(4) == LOW ) {
    digitalWrite(2, LOW);          //Yellow LED
    digitalWrite(3, HIGH);         //Green LED
  }//End if


  //Potentiometer Controls
  //Left Potentiometer - Left & right line movement
  if ((analogRead(A0) > 0) && (analogRead(A0) < 300)) { //Check if the potentiometer is moving in the left direction
    Serial.println("l");                                //Send a string to the console to be read by Processing
    int x = analogRead(A0);                             //Store the current potentiometer value in a variable x
    Serial.println(x);                                  //Print variable x to the monitor
    
  } else if ((analogRead(A0) > 300) && (analogRead(A0) < 800)) { //Check if the potentiometer is in the center, allowing no movement
    Serial.println("Left potentiometer - Dont move");   //Print that there is no movement to the monitor
    int x = analogRead(A0);                             //Store the current potentiometer value in a variable x
    //Serial.println(x);                                //Print variable x to the monitor
    
  } else if (analogRead(A0) > 800)  {                   //Check if the potentiomete is in the right direction
    Serial.println("r");                                //Send a string to the console to be read by processing
    int x = analogRead(A0);                             //Store the current potentiometer to be read in Processsing
    Serial.println(x);                                  //Print variable x to the monitor
  }//End if - left potentiometer

  //Right Potentiometer - Up & down line movement
  if ((analogRead(A1) > 0) && (analogRead(A1) < 300)) { //Check if the potentiometer is moving in the vertical direction upwards
    Serial.println("d");                                //Send a string to the console to be read by Processing
    int x = analogRead(A1);                             //Store the current potentiometer value in variable x
    Serial.println(x);                                  //Print the variable x to the monitor
    
  } else if ((analogRead(A1) > 300) && (analogRead(A1) < 800)) {  //Check if the potentiometer in the center, allowing no movement
    Serial.println("Right potentiometer - Dont move");  //Print that there is no movement
    int x = analogRead(A1);                             //Store the current potentiometer value in variable x
    Serial.println(x);                                  //Print variable x to the monitor
    
  } else if (analogRead(A1) > 800)  {                   //Check if the potentiometer is moving in the vertical direction downwards
    Serial.println("u");                                //Send a string to the console to be read by Processing
    int x = analogRead(A1);                             //Store the current potentiometer value in variable x
    Serial.println(x);                                  //Print variable x to the monitor
  }//End if - right potentiometer
  
  delay( 50 );                                    //Delay the entire loop
  
}//End void loop()
