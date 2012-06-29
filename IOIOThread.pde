class myIOIOThread extends Thread {

  boolean running;
  String id;
  int wait;
  DigitalOutput led;
  AnalogInput in;
  int count;
  int ledpin = 3; //pin for our led
  int potpin = 36; // pin for our potentiometer
  float value; //our analog values range from 0 to 1


  myIOIOThread(String s, int w) {

    id = s;
    wait = w;
    running = false;
    count = 0;
    
  }


  void start() {
    running = true;

    try {
      IOIOConnect();
    } 
    catch (ConnectionLostException e) {
    }


    try {
      
      led = ioio.openDigitalOutput(ledpin);
      in = ioio.openAnalogInput(potpin);
    } 
    catch (ConnectionLostException e) {
    }


    super.start();
  }

  void run() {
    
    while (running) {
      //count++;
      try {
        led.write(lightOn);
        value = in.read();
      } 
      catch (ConnectionLostException e) {
      }
      catch (InterruptedException e) {
      }

      try {
        sleep((long)(wait));
      } 
      catch (Exception e) {
      }
    }
  }

  void quit() {
    running = false;
    //led.close();
    ioio.disconnect();
    interrupt();
  }



  void IOIOConnect() throws ConnectionLostException {

    try {
      ioio.waitForConnect();
    }
    catch (IncompatibilityException e) {
    }
  }
}

