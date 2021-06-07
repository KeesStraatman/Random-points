# Creating random points and measure distance to objects of interest

This macro will create random points in the binary image and measures the shortest distance of the points to objects of interest (value = 255), records mean distance per simulation off all points and only the points outside the objects of interest and prints this in a log file. It also will record how many points are inside the objects of interest. The macro assumes you have a binary image open and can handle single images and stacks.

The macro can be used to obtain an unbiased estimate of the proportion of each image that is occupied by the object of interest. However, see also this discussion ([ImageJ - Generating random points and tallying proportion of points that fall within object (nabble.com)](http://imagej.1557.x6.nabble.com/Generating-random-points-and-tallying-proportion-of-points-that-fall-within-object-td5007988.html#a5007991)) on the mailing list.

The user can set the number of repeats and the number of points randomly placed in the image. The user can also indicate if the points should be placed over the whole image or only outside the objects of interest.

The name of the results table includes the name of the image, a unique number and the number of points used in the analysis. 

As starting point I used the code published by Olivier Burri on the ImageJ mailing list (see above link) on 2 June 2014.

## Download code

Select the file "RandomPointsTo_Objects.ijm" and select "Raw" from the right side menu. Select all the code and copy and paste this into the text editor from ImageJ/Fiji (File > New > Text Window). Alternatively, you can download all files via the green "Code" button as a ZIP file and extract the macro file. Save this file in your macros sub-folder within the ImageJ or Fiji folder with the name RandomPointsTo_Objects.ijm.

## Run macro

To run the macro a single time create a results table and via Plugins > Macros > Run... select the macro. Alternatively install it via Plugins > Macros > Install ... and the macro will be added to the Plugins > Macros menu, till you restart ImageJ/Fiji.

## Disclaimer

All the macros published on this repository can be used at your own risk. Although I did my best to ensure that they run as intended, there may be bugs, not expected use or changes to the ImageJ code that results in unexpected behaviour. If you notice a problem with any of the macros please let me know and I will try to solve the problem.