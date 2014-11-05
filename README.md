Elevator Algorhythm
========

Perfect elevator algorhythm tryout. From simple "one elevator in a building" to "10 high speed elevators in 100-floors business building" simulation.

Parameters
========

Common attributes:

* number_of_elevators (integer)
* number_of_floors (integer)
* max_speed (float, meters/second)
* acceleration (float, meters/second^2)
* deceleration (float, meters/second^2)
* maximum_weight (integer, kg)
* minimum_person_weight (integer, kg)
* maximum_person_weight (integer, kg)
* maximum_persons_in_cabin (integer)
* maximum_group_size (integer)


Group of persons attributes:

* persons (array)
* allow_to_split (boolean) - can't split families.


Rules
========

* Elevator can't change direction until it reach last point of current direction.
* Elevator stops on weight overload.
* Elevator stops on maximum persons in cabin overload.
* @todo

