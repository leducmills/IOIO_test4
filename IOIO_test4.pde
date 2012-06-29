/* IOIO Test 4 - 
 * Toggling a real LED on pin 3, and reading values from a potentiometer on pin 37 through Processing in Android mode
 * by Ben Leduc-Mills
 * This code is Beerware - feel free to reuse and credit me, and if it helped you out and we meet someday, buy me a beer.
 */

import apwidgets.*;

import ioio.lib.util.*;
import ioio.lib.impl.*;
import ioio.lib.api.*;
import ioio.lib.api.exception.*;

APWidgetContainer widgetContainer; 
APButton button1;
int rectSize = 100;
boolean lightOn = false;


IOIO ioio = IOIOFactory.create();
myIOIOThread thread1; 

void setup() {
  thread1 = new myIOIOThread("thread1", 100);
  thread1.start();

  size(480, 800); 
  smooth();
  noStroke();
  fill(255);
  rectMode(CENTER);     //This sets all rectangles to draw from the center point

  widgetContainer = new APWidgetContainer(this); 
  button1 = new APButton(10, 10, "Toggle LED"); 
  widgetContainer.addWidget(button1); //place button in container
}

void draw() {
  background(#FF9900);
  //change the fill value based on the analog read of our potentiometer
  fill(thread1.value * 100); //it's * 100 because we only get values from 0-1, so really this should be * 255, or use the map function
  rect(width/2, height/2, rectSize, rectSize);
}


//onClickWidget is called when a widget is clicked/touched
void onClickWidget(APWidget widget) {

  if (widget == button1) { //if it was button1 that was clicked

    if (lightOn == true) {
      lightOn = false;
      rectSize = 50;
    }
    else if (lightOn == false) {
      lightOn = true; 
      rectSize = 100;
    }
  }
}

