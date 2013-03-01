##Building a Landscape

###Problems:
* In Land:
	* ~~clustering in two and fall to the right side~~
* In Ocean:
	* ~~Changing landscape at the wrong location~~
* Make mouse vector only affect the landscape it is hovered over
	* grab area of landscape or bounds and check if mouse falls in those bounds (is this the same as edges method?,) refresh landscape only after all movers have been drawn, two for loops, one for each landscape? 	

###Ideas:
* Evolution:
	* ~~relative closeness to border of landscape over a certain amount of times leads to the mover changing "loyalty" to another landscape~~ 
* Add more forces and more kinds of movers with different behaviors
* add agitating and equalizing tendency
*  give depth to ocean so creatures look like they are moving within 3d plane, gravity pushes them down (ellipses looking smaller) look at mover in box example, transform space to see below like Landscape example


###Still need to add:
Random walk type, Modified-semi-random walk, gaussian, perlin||noise, ~~Vector Addition~~, Vector Scalings


Think about using ArrayList versus static sized array to get rid of and create new creatures

New Graphics Frames to change elements (deal with data before showing the screen)


Check out Nara's example using 3D bounding boxes, moving bounding boxes as units un related to each other
PCCamera -- shifting persepective


new mods oscillation techniques

written document that addresses issues about project listed on the syllabus


HOMEWORK:
NOC Chapter 2: programming exercises: 2.1, 2.3, 2.4, 2.5 *Include at least 1 of these forces in your eco-system vsn1
 optional 2.2, 2.6; Get started on Chapter 3 Oscillation code