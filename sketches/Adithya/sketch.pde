int Spacing = 50;
int XPos = 0;
int YPos= 0;

color[] mycolors = {#ffb5b5,#7de5f6,#8a2be2,#a9ff71,#0000ff};

// Amazing code as you can see
// Chose colourful colours , cause its a colourful day.
void setup() {
  size(1000,1000);
  colorMode(HSB);
}
//mouse pressed will change the colour of triangles.
void mousePressed() {
  background(900);
  noStroke();
  for(int XPos=0;XPos<500;XPos=XPos+100) {
    for (int YPos=0;YPos<500;YPos=YPos+100) {
      fill(mycolors [int(random(0,4))]);
      triangle(XPos, YPos, XPos, YPos+Spacing, XPos+Spacing, YPos+Spacing);
      fill(mycolors [int(random(0,4))]);
      triangle(XPos, YPos, XPos+Spacing, YPos, XPos+Spacing, YPos+Spacing);
    }
  }
// Spacing affects how far apart the triangles are, XPos, YPos control the spacing vertically and horizontally.
// Click

  for(int XPos=0;XPos<500;XPos=XPos+100) {
    for (int YPos=0;YPos<500;YPos=YPos+100) {
      fill(mycolors [int(random(0,4))]);
      triangle(XPos+50, YPos+50, XPos+50, YPos+Spacing+50, XPos+Spacing+50, YPos+Spacing+50);
      fill(mycolors [int(random(0,4))]);
      triangle(XPos+50, YPos+50, XPos+Spacing+50, YPos+50, XPos+Spacing+50, YPos+Spacing+50);
    }
  }

  for(int XPos=0;XPos<500;XPos=XPos+100) {
    for (int YPos=0;YPos<500;YPos=YPos+100) {
      fill(mycolors [int(random(0,4))]);
      triangle(XPos+50, YPos+Spacing, XPos+Spacing+50, YPos+Spacing, XPos+Spacing+50, YPos);
      fill(mycolors [int(random(0,4))]);
      triangle(XPos+50, YPos+Spacing, XPos+50, YPos, XPos+Spacing+50, YPos);
    }
  }


  for(int XPos=0;XPos<1000;XPos=XPos+100) {
    for (int YPos=0;YPos<1000;YPos=YPos+100) {  
      fill(mycolors [int(random(0,4))]);
      triangle(XPos, YPos+Spacing+50, XPos+Spacing, YPos+Spacing+50, XPos+Spacing, YPos+50);
      fill(mycolors [int(random(0,4))]);
      triangle(XPos, YPos+Spacing+50, XPos, YPos+50, XPos+Spacing, YPos+50);
    }
  }
}
void draw() {
}
