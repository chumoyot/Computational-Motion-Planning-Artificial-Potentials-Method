# Computational-Motion-Planning-Artificial-Potentials-Method
A different method of motion planning entails the creation of artificial potential fields that are intended to draw the robot to the desired target configuration and repel it from obstructions in the configuration space. The gradient of this potential function can then be used to direct the robot's mobility. Obstacles repulse objects and prevent them from colliding with them. 

The explanation which explains it in the easiest way possible is here. https://blog.csdn.net/junshen1314/article/details/50472410 

Let's see how to construct the fields.

(1) Attractive Force: Gravitational field is given by the equation.
![111](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/b135b934-e1c9-4996-8b60-cda992e9e4b0)  
Where xi is the scaling factor, ( (x - goal(1)).^2 + (y - goal(2)).^2 ) represents the distance from the target to the current position. 

Repulsive Force: 
![3333](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/c95d2585-2e57-46fa-95f2-82c650ddead6)
nu is the repulsive scale factor, do is a scalar representing the radius of influence of each obstacle, d2 is a matrix representing the distance between the object and obstacle. The obstacle has no repulsive effect on the object after a certain distance [d2>do]. 

The total field is the superposition of the attractive and repulsive fields.
![444](https://github.com/chumoyot/Computational-Motion-Planning-Artificial-Potentials-Method/assets/135506318/6cce5616-4c6e-4faf-8023-fb929460d64f)
The resultsnt force on each object is the sum of its repusive and attractive forces. 
