run("Set Measurements...", "area centroid fit shape redirect=None decimal=3");
run("Clear Results");
getDimensions(width, height, channels, slices, frames);
title = getTitle();
mapTitle = replace(title, "\\..*$", " - Vessel ID Map.tif"); 
newImage(mapTitle, "16-bit black", width, height, 1);
selectWindow(title);
while(getBoolean("Would you like to measure a blood vessel?")){
	setTool("polygon");
	waitForUser("Please draw an outline around a vessel.");
	tool = IJ.getToolName();
	type = selectionType();
	if(matches(tool, "polygon") && type == 2){
		if(getBoolean("Would you like to measure this vessel?")){
			run("Measure");
			run("Set...", "value=0");
			run("Select None");
			selectWindow(mapTitle);
			run("Restore Selection");
			run("Set...", "value=" + nResults + 1);
			run("Select None");			
			setMinAndMax(0,nResults + 1);
		}
	}
	else{
		if(type == -1) waitForUser("No selection was drawn.");
		else{
			waitForUser("Incorrect selection type");
			run("Select None");
		}
	}
	selectWindow(title);
}
