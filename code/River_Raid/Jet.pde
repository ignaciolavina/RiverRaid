class Jet extends Element{
  
  PImage imageCrashed;
  private float fuel;
  private boolean crashed = false;

  private int reserveJets = 3;
  private int lastFired = 0;
  protected float FIRE_DELAY = 40.0;
  public float fireCooldown = 0;
  public boolean firingMode = false;
  public boolean refueling = false;
  public int type;
  
  private int lives = 3;
  int DEFAULT_LIVES = 3;
  
   Jet(){
     super("./images/sprites/jet.png", 80, 130);
     imageCrashed = getImage("./images/sprites/crash.png", 80, 130);
     yPos = 800;
     xPos = 500;
     fuel = INITIAL_FUEL;
     type = 0;
   }
   
   Jet(int jetB){
     super("./images/sprites/jet_2.png", 80, 130);
     imageCrashed = getImage("./images/sprites/crash.png", 80, 130);
     yPos = 800;
     xPos = 300;
     fuel = INITIAL_FUEL;
     type = 1;
   }
   
   public void draw(float yMaster){
     if(!crashed)
       image(this.image, x(xPos), y(yPos - yMaster));
     else
       image(this.imageCrashed, x(xPos), y(yPos - yMaster));
   }
   
   public void moveLeft(){
     if (xPos >= 0 + offsetX)
     xPos = xPos - 7;
     
   }
   
   public void moveRight(){
     if (xPos <= 1000 - offsetX)
     xPos = xPos + 7;
   }
   
   public void consume(float nD){
     if(this.fuel > 0)
      this.fuel = (this.fuel - VELOCITY_CONSUMPTION*gameSpeed*2*nD);
     else{
        this.crashed = true;
        jet.removeReserveJet();
        //sound effect
        sound.playCrashSound();

        timeResetWorld=millis();
     }
  }
  
  /*** REFUEL ***/
  public void checkRefuel(float nD){

    if(world.checkCollision(this, World.C_FUEL_DEPOTS)){
        this.refuel(nD);
        VELOCITY_CONSUMPTION = 0;
        this.refueling = true;
    }else{
        VELOCITY_CONSUMPTION = 0.1;
        this.refueling = false;
    }
  }
  
  public void refuel(float nD){
    int refuelSpeed = 3;
    if(gameSpeed < DEFAULT_SPEED){
      refuelSpeed = 8;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed * nD);
    }
  }
   
   
   /* COLLISION  */
   public void checkCollision(){
    if(world.checkCollision(this, World.C_OBSTACLES)){
        this.crashed = true;
        jet.removeReserveJet();
        //sound effect
        sound.playCrashSound();

        timeResetWorld=millis();
    }
  }
  
  public boolean fire() {
     if(fireCooldown > 0) return false;
     
     fireCooldown += FIRE_DELAY;
     Rocket rocket = new Rocket(false);
     if(this.firingMode == true)
       rocket.xPos = this.xPos + jet.width - rocket.width;
     else
       rocket.xPos = this.xPos;
     this.firingMode = !this.firingMode;
     rocket.yPos = this.yPos + 60;
     rockets.add(rocket);

     //sound effect
     sound.playShootSound();
     
     return true;
  }
  
  public void update(float nD) {
    if(fireCooldown > 0)
      fireCooldown -= nD;
    jet.yPos = yMaster+800;
  }
  
  public float getFuel(){
     return fuel;
   }  
   
   public void setFuel(int fuel){  
     this.fuel = fuel;
   }
   
  public int getReserveJets(){
     return this.reserveJets; 
  }
  
  public void addReserveJet(){
    this.reserveJets++;
  }
  
  public void removeReserveJet(){
    if(this.reserveJets >= 0)   
      this.reserveJets--;
      
    if (this.reserveJets < 0)
      gameState = gameState.END;     
     
  }
  
  public void updateSelected(int selected){
    type = selected;
    if(selected == 0){
      //jet.image = getImage("./images/sprites/jet.png", 80, 130);
      FIRE_DELAY = 40.0;
      DEFAULT_SPEED = 3;
    }else{
      jet.image = getImage("./images/sprites/jet_2.png", 90, 80);
      FIRE_DELAY = 80.0;
      DEFAULT_SPEED = 2.5;
    }
  }
  
  public int getLives(){
    return lives;
  }
  
  public void removeLive(){
    if(lives > 0)
      lives--;
  }
  
  public void resetLives(){
    this.lives = DEFAULT_LIVES;  
  }
}