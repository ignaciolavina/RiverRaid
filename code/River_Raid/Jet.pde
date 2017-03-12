public class Jet {
  
  private int id;  // in case we desing more jets
  private PImage jet_image = loadImage("./images/sprites/jet.png");
  
  //jet coordenates
  private int x;
  private int y;
  
  private int fuel;
  
  public Jet(){
    x= 500;
    y = 900;
    jet_image.resize(w(width/20), h(height/10));  
    fuel = INITIAL_FUEL;
  }
  
  public void draw(){    
    image(jet_image, x(x), y(y));
  }
  /*
  public Jet (){  //Actually in the constructor should receive the map
  jet_image = loadImage("./images/sprites/jet.png");
  image(jet_image, x, y);
  jet_image.resize(width/15, height/11);  
  }
  */
  
  public int getX(){
       return x; 
  }

  public void setX(int x){
     this.x= x; 
  }
  
  public int getY(){
     return y; 
  }
  
  public void setY(int y){
      this.y=y;
  }
  
  public int getFuel(){
    return fuel;
  }
  
  public void setFuel(int fuel){
    this.fuel = fuel;
  }
  public PImage getImage(){
    return jet_image;
  }
  
  public void moveLeft(){
      x= x-10;
      translate(x, y);
      //image(jet_image, x, y);
  }
   
   public void moveRight(){
      x= x+10;
      translate(x, y);
      //image(jet_image, x, y);
  }
  
  public void consume(){
    this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*speed);
  }
  
  /*** REFUEL ***/
public void checkRefuel(FuelDepot fuelDepot){
  int fuelDepotY = fuelDepot.getY();
  if(fuelDepotY < 0){
    fuelDepotY = 1000 + fuelDepotY;
  }
  
  if((jet.getX() >= fuelDepot.getX()) && (jet.getX() + jet.getImage().width <= fuelDepot.getX() + fuelDepot.getImage().width) &&
      ( (jet.getY() >= fuelDepotY) && (jet.getY() <= fuelDepotY + fuelDepot.getImage().height) ) ){
        jet.refuel();
        VELOCITY_CONSUMPTION = 0;
  }else{
      VELOCITY_CONSUMPTION = 0.1;
  }
}

  
  public void refuel(){
    int refuelSpeed = 3;
    
    if(speed < DEFAULT_SPEED){
      refuelSpeed = 10;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed);
    }
  }
}