PFont font;

// Building settings
int number_of_elevators = 5;
int number_of_floors = 5;
float floor_height = 3;
Building building;

// Display settings
int _scale_meters_to_pixels = 20; // pixels

// Elevator settings
float max_speed = 3.0;
float acceleration;
float deceleration;
int maximum_weight = 600;
int maximum_persons_in_cabin = 8;

// Humans settings
int minimum_person_weight = 20;
int maximum_person_weight = 110;
int maximum_group_size = 12;

void setup() {
  building = new Building(number_of_floors, number_of_elevators, floor_height); 
  size( int(scale_dimensions(building.width()) ), int(scale_dimensions(building.height()) ) );
  smooth();
  font = createFont("Arial",16,true);
}


void draw() {
  background(255);
  for(int i = 0; i < building.elevators.length; i++) {
    building.elevators[i].startMovingTo( int(random(building.number_of_floors)) );
    building.elevators[i].move();
  }
  building.draw();
}


// Convert meters to pixels
float scale_dimensions(float meters) {
  return meters * _scale_meters_to_pixels;
}





class Building {
  
  int number_of_floors;
  int number_of_elevators;
  float floor_height;
  Elevator[] elevators;
  
  
  Building(int _number_of_floors, int _number_of_elevators, float _floor_height) {
    number_of_floors = _number_of_floors;
    number_of_elevators = _number_of_elevators;
    floor_height = _floor_height;
    
    // Init elevators
    this.elevators = new Elevator[number_of_elevators];
    for(int i = 0; i < number_of_elevators; i++) {
      this.elevators[i] = new Elevator(i);
    }
    
  }
  
  float width() {
    return number_of_elevators * floor_height;
  }
  
  float height() {
    return number_of_elevators * floor_height;
  }
  
  void draw() {

    // Draw elevators
    pushMatrix();
    for(int i = 0; i < this.elevators.length; i++) {
      this.elevators[i].draw(); 
      translate(scale_dimensions(building.floor_height), 0);
    }
    popMatrix();
    
  }
  
}


class Elevator {
  
  int id;
  float current_floor = 0.0;
  float destination_floor = -1;
  int moving_direction = 0;
  
  Elevator(int _id) {
    id = _id;
  }
  
  void startMovingTo(float _destination_floor) {
    if(destination_floor == -1) {
      destination_floor = _destination_floor;
    }
    if( destination_floor > current_floor ) {
      moving_direction = 1;
    } else if( destination_floor < current_floor ) {
      moving_direction = -1;
    } else {
      // Same floor
      moving_direction = 0;
      current_floor = destination_floor;
      destination_floor = -1;
    }
  }
  
  void move() {
    if(destination_floor != -1) {
      if( current_floor != destination_floor ) {
        current_floor += float(moving_direction) / 20.0;
        if( current_floor >= destination_floor && moving_direction == 1) {
          current_floor = destination_floor;
          destination_floor = -1;
          moving_direction = 0;
        }
        if( current_floor <= destination_floor && moving_direction == -1) {
          current_floor = destination_floor;
          destination_floor = -1;
          moving_direction = 0;
        }
      }
    }  
  }
  
  void draw() {
    rectMode(CORNER);
    stroke(0);
    rect(
      0,
      scale_dimensions((building.number_of_floors - 1 - current_floor) * building.floor_height ), // Minus 1 because floors numbers from 0 
      scale_dimensions(building.floor_height), 
      scale_dimensions(building.floor_height)
    );
  }
  
}
