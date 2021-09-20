// This macro assumes you have a binary image open. 
// It will create random points in the binary image and measures the shortest distance of the points to objects of interest (value = 255),
// records mean distance per simulation off all points and only the points outside the objects of interest and prints 
// this in a log file. It also will record how many points are inside the objects of interest.
// The user can set the number of repeats and the number of points randomly placed in the image. The user can also indicate
// if the points should be placed over the whole image or only outside the objects of interest.

// The name of the results table includes the name of the image, a unique number and the number of points used in the analysis. 
// 
// As starting point I used the code published by Olivier Burri on the ImageJ mailing list on 2 June 2014:
// 'Generating random points and tallying proportion of points that fall within object' 

// Kees Straatman, University of Leicester, 12 August 2018

// 07/06/2021 Macro can handle stacks

// 20/09/2021 Resolved a bug that caused the stack analysis to fail

macro randomDotsTo_Objects{
	
	// Set settings
	run("Set Measurements...", "mean redirect=None decimal=3");
	run("Point Tool...", "type=Hybrid color=Red size=Small label");
	
	// Number of points to generate and numer of repeats
	repeats = 1000;
	n_points = 100; 

	title = getTitle();

	
	Dialog.create("Settings");
		Dialog.addNumber("Number of simulations", repeats);
		Dialog.addNumber("Number of points per simulation", n_points);
		Dialog.addCheckbox("Select only points outside objects of interest", false);
	Dialog.show();
	repeats = Dialog.getNumber();
	n_points = Dialog.getNumber();
	select = Dialog.getCheckbox();

	setBatchMode(true);

	getDimensions(x,y,z,c,t); // Size of the image 

	for(stack = 1; stack<=c; stack++){

		Stack.setSlice(stack);

		for (rep=1; rep <=repeats; rep++){
			// Initialize arrays that will contain point coordinates 
			xcoords = newArray(n_points); 
			ycoords = newArray(n_points); 
	
			// Seed the random number generator 
			random('seed', getTime()); 

			// Create n_points points in XY 
			for (i=0; i<n_points; i++) { 
				xcoords[i] = round(random()*x); 
       			ycoords[i] = round(random()*y); 
				// Check that the point is not on the boarder of the image; mean will be NaN and distance 1
       			if ((xcoords[i]==x)||(ycoords[i]==y)){
       				i = i-1;
       			}
			} 

			// Overlay them on the image 
			makeSelection("point", xcoords, ycoords); 

			// create point list + results
			prevRes = nResults;

			// check points 
			count = 0;	// counts number of dots inside objects of interest
			distance = 0;
	 
			for (i=0; i<n_points;i++) { //Generating random points and tallying proportion of points that fall within object
				// select point
       			makePoint(xcoords[i], ycoords[i]); 
       			getStatistics(area, mean, min, max, std, histogram); 
			
				// Count points that have a value of 255 and distance 0 (are inside objects of interest)       
				if (mean == 255) { 
					if (select==false){
						count++;
					}else{
						// in case only points outside objects of interest are required create a new point
						xcoords[i] = round(random()*x); 
       					ycoords[i] = round(random()*y); 
       					i=i-1; 
					}

        		}else{
        	        		
        			d=0; // counter for pixels enlarged
        		
        			// find when point hits object of interest (=value of 255)
        			while (mean==0){
        				run("Enlarge...", "enlarge=1");
        				if (d==0) run("Fit Circle");
        				getStatistics(area, mean, min, max, std, histogram); 
        				d=d+1;
        			
        			}
	       			distance = distance + d;
        		}

			} 
		
			// calculate average distance
			avDisAll = distance/n_points; // all points
			avDiss = distance/(n_points-count);
			perc = count/n_points*100;
	
			// Print results
			
			// Create header 
			if ((rep==1)&&(stack==1)){
								
				if (c == 1){ // Single image
					TN = "["+title+"-"+(round(getTime()/1000))+"_"+n_points+" points]";
					run("New... ", "name="+TN+"  type=Table");
					print(TN, "\\Headings: \tMean distance\tMean distance points outside\tNumber of points inside\t% of points inside");
				}else{
					TN = "["+title+"-"+(round(getTime()/1000))+"_"+n_points+" points]";
					run("New... ", "name="+TN+"  type=Table");
					print(TN, "\\Headings: \tImage\tMean distance\tMean distance points outside\tNumber of points inside\t% of points inside");
				}
			}
				
			// Output to log window.
			if (c == 1){
				print(TN, rep+"\t"+avDisAll+"\t"+avDiss+"\t"+count+"\t"+perc);
			}else{
				print(TN, "image "+stack+"\t"+rep+"\t"+avDisAll+"\t"+avDiss+"\t"+count+"\t"+perc);
			}		
		
		}

	
	} // End of repeat
	
}// End of macro 