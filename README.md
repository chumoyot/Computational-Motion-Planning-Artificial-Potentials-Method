# Computational-Motion-Planning-Artificial-Potentials-Method
A different method of motion planning entails the creation of artificial potential fields that are intended to draw the robot to the desired target configuration and repel it from obstructions in the configuration space. The gradient of this potential function can then be used to direct the robot's mobility. Obstacles repulse objects and prevent them from colliding with them. 

The explanation which explains it in the easiest way possible is here. https://blog.csdn.net/junshen1314/article/details/50472410 

Let's see how to construct the fields.

(1) Attractive Force: 

Gravitational field is given by the equation.

![111](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/b135b934-e1c9-4996-8b60-cda992e9e4b0)  

Where xi is the scaling factor, ( (x - goal(1)).^2 + (y - goal(2)).^2 ) represents the distance from the target to the current position. 


Repulsive Force: 

![3333](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/c95d2585-2e57-46fa-95f2-82c650ddead6)

nu is the repulsive scale factor, do is a scalar representing the radius of influence of each obstacle, d2 is a matrix representing the distance between the object and obstacle. The obstacle has no repulsive effect on the object after a certain distance [d2>do]. 

The total field is the superposition of the attractive and repulsive fields.


![444](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/6cce5616-4c6e-4faf-8023-fb929460d64f)
The resultsnt force on each object is the sum of its repusive and attractive forces. 

Again, from my seat, I modelled my indoor environment with walls representing obstacles and rooms representing free spaces but it run into a local minimum. With slight pertubation to the object, I would set it on course again to the goal location, I will probably update here once I do that. Here are the visuals with some random obstacles.

Configuration Space showing obstacles and free spaces in a 2D environment.

![C Space](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/d3dc7dae-172e-4a79-8055-ada5dd328dbd)

Quiver PLot: Where the arrows indicate the direction of the gradient field at various locations in the configuration space. The red path is the route taken by the robot.

![quiver plot](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/b3a775b3-8db2-4513-95e9-4d9156f45e6f)

Total Potential:

![total potential](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/6e3ca1a8-2be3-4093-9eef-b74e7b3d9442)

Attractive potential: It is constructed via a simple quadratic function, that is zero at the goal and increases as you move away from it, as shown below.

![attractive potential](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/3ada06cb-5cff-4bb3-ba2e-78c4234c073b)

