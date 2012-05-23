#include <Keypad.h>
#include <LiquidCrystal.h>
#include <Wire.h> 
 
#define REDLITE 3
#define GREENLITE 5
#define BLUELITE 6

#define TITLE "KeyPad & LCD  __"
#define READY "Ready ...       "
#define EMPTY "              "
 
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7, 8, 9, 10, 11, 12);
 
// you can change the overall brightness by range 0 -> 255
int brightness = 255;

const byte ROWS = 4; //four rows
const byte COLS = 3; //three columns
char keys[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};
byte rowPins[ROWS] = {2, 3, 4, 5}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {6, 14, 15}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

void setup()
{
  // set up the LCD's number of rows and columns: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print(TITLE);
  lcd.setCursor(0,1);
  lcd.print(READY);
 
  brightness = 100;
  
  Serial.begin(9600);
}

int index = 1;
char digits[2] = {' ',' '};

void loop(){

  char key = keypad.getKey();

  if (key != NO_KEY)
  {
    index = !index;   
    
    if(key == '*')
    {
      index = 1;
      digits[0] = ' ';
      digits[1] = ' ';
      lcd.setCursor(0,0);
      lcd.print(TITLE);
      lcd.setCursor(0,1);
      lcd.print(READY);
    }
    else if(key == '#')
    {
      // Animation
      for(int i=0; i<15;i++)
      {
        lcd.setCursor(0,1);
        lcd.print(EMPTY);
        lcd.setCursor(i,1);
        lcd.print(digits);
        delay(100);
      }
      
      lcd.setCursor(0,1);
      lcd.print(EMPTY);
      lcd.setCursor(14,0);
      lcd.print(digits);
      
      index = 1;
      digits[0] = ' ';
      digits[1] = ' ';
      lcd.setCursor(0,1);
      lcd.print(READY);
    }
    else
    {
      digits[index] = key;
      lcd.setCursor(0,1);
      lcd.print(digits);
      lcd.print(EMPTY);
    }
    
    Serial.println(key);    
  }  
}


