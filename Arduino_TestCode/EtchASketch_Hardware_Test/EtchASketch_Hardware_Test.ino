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
int potL;
int potR;

void setup() {
  //Declare all our pins for the arduino components
  //Movement
  pinMode(A0, INPUT);       //Potentiometer (left):
  pinMode(A1, INPUT);       //Potentiometer (right):

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
}//End setup

void loop() {
    Serial.println( "" );
    Serial.println( "Arduino - Component Test." );

    digitalWrite(2, HIGH);
    digitalWrite(3, HIGH);
    digitalWrite(5, HIGH);
    digitalWrite(6, HIGH);
    digitalWrite(7, HIGH);
    digitalWrite(9, HIGH);
    digitalWrite(10, HIGH);
    digitalWrite(11, HIGH);

    Serial.println( "Buttons:" );
    if( digitalRead(4) == HIGH ) {
      Serial.println( "Blue button is pressed and is being received and working by the arduino." );
    } else if( digitalRead(4) == LOW ) {
      Serial.println( "Blue button is NOT pressed but it being received working on the arduino." );
    } else {
      Serial.println( "Blue button is NOT being received by the arduino!." );
    }//End if
    
    if( digitalRead(8) == HIGH ) {
      Serial.println( "Grey button is pressed and is being received and working by the arduino." );
    } else if( digitalRead(8) == LOW ) {
      Serial.println( "Grey button is NOT pressed but it being received working on the arduino." );
    } else {
      Serial.println( "Grey button is NOT being received by the arduino!." );
    }//End if
        
    if( digitalRead(12) == HIGH ) {
      Serial.println( "Yellow button is pressed and is being received and working by the arduino." );
    } else if( digitalRead(12) == LOW ) {
      Serial.println( "Yellow button is NOT pressed but it being received working on the arduino." );
    } else {
      Serial.println( "Yellow button is NOT being received by the arduino!." );
    }//End if



    Serial.println( "Potentiometer:" );
    //Left pot
    if( analogRead(A0) > 0 ) {
      int x = analogRead(A0);
      Serial.println(x);
    } else {
      Serial.println( "Potentiometer left is NOT working." );
    }//End if

    if( analogRead(A1) > 0 ) {
      int y = analogRead(A1);
      Serial.println(y);
    } else {
      Serial.println( "Potentiometer right is NOT working." );
    }//End if
    


    delay( 3000 );
}//End loop()

