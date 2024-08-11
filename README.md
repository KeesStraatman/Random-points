# Creating random dots/points and measure distance to objects of interest

This macro will create random dots in the binary image and measures the shortest distance of the dots to objects of interest (value = 255), records mean distance per simulation off all dots and only the dots outside the objects of interest and prints this in a log file. It also will record how many dots are inside the objects of interest. The macro assumes you have a binary image open and can handle single images and stacks.

The macro can be used to obtain an unbiased estimate of the proportion of each image that is occupied by the object of interest. However, see also the discussion "Generating random points and tallying proportion of points that fall within object" on the ImageJ mailing list (https://list.nih.gov/cgi-bin/wa.exe?A0=IMAGEJ).

The user can set the number of repeats and the number of dots randomly placed in the image. The user can also indicate if the dots should be placed over the whole image or only outside the objects of interest.

The name of the results table includes the name of the image, a unique number and the number of dots used in the analysis. 

As starting point, I used the code published by Olivier Burri on the ImageJ mailing list (see above link) on 2 June 2014.

## Download code

Select the file "RandomDotsTo_Objects.ijm" and select "Raw" from the right side menu. Select all the code and copy and paste this into the text editor from ImageJ/Fiji (File > New > Text Window). Alternatively, you can download all files via the green "Code" button as a ZIP file and extract the macro file. Save this file in your macros sub-folder within the ImageJ or Fiji folder with the name RandomDotsTo_Objects.ijm.

## Run macro

To run the macro a single time create a results table and via Plugins > Macros > Run... select the macro. Alternatively install it via Plugins > Macros > Install ... and the macro will be added to the Plugins > Macros menu, till you restart ImageJ/Fiji.

## Disclaimer

All the macros published on this repository can be used at your own risk. Although I did my best to ensure that they run as intended, there may be bugs, not expected use or changes to the ImageJ code that results in unexpected behaviour. If you notice a problem with any of the macros please let me know and I will try to solve the problem.
