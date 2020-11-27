/*
Japanese Chord Gloves
 for use with the Makey Makey
 
 by MASOOD
 
 November 27, 2020
 
 Acknowledgements:
 Adapted from code by Neel Virdy
 https://www.openprocessing.org/sketch/99584/#
 
 Minim
 An audio library for Processing
 https://github.com/ddf/Minim
 
 */

import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;

PImage base;
PImage thumb;
PImage index;
PImage middle;
PImage ring;
PImage pinky;

boolean bBase;
boolean bThumb;
boolean bIndex;
boolean bMiddle;
boolean bRing;
boolean bPinky;

int octave = 0;

// Lowest Octave / Root Position
Chord3 iii_E_0;
Chord3 iv_F_0;
Chord3 v_G_0;
Chord3 vi_A_0;

// Middle Octave / 1st Inversion
Chord3 iii_E_1;
Chord3 iv_F_1;
Chord3 v_G_1;
Chord3 vi_A_1;

// Highest Octave / 2nd Inversion
Chord3 iii_E_2;
Chord3 iv_F_2;
Chord3 v_G_2;
Chord3 vi_A_2;

color fillVal = color(255);

void setup() {
  size(500, 500);
  //fullScreen(); 

  base = loadImage("data/00-hand-base.png");
  thumb = loadImage("data/01-thumb-white.png");
  index = loadImage("data/02-index-red.png");
  middle = loadImage("data/03-middle-orange.png");
  ring = loadImage("data/04-ring-yellow.png");
  pinky = loadImage("data/05-pinky-green.png");

  imageMode(CENTER);

  // Initialize chords
  iii_E_0 = new Chord3(164.859, 207.727, 247.030);
  iv_F_0 = new Chord3(174.674, 220.000, 262.686);
  v_G_0 = new Chord3(196.065, 247.030, 293.724);
  vi_A_0 = new Chord3(220.000, 277.262, 329.724);

  iii_E_1 = new Chord3(207.727, 247.030, 329.724);
  iv_F_1 = new Chord3(220.0, 261.686, 349.309);
  v_G_1 = new Chord3(247.030, 293.724, 392.089);
  vi_A_1 = new Chord3(277.262, 329.724, 440.0);

  iii_E_2 = new Chord3(246.94, 329.63, 415.3);
  iv_F_2 = new Chord3(261.63, 329.63, 440.0);
  v_G_2= new Chord3(293.67, 392.00, 493.88);
  vi_A_2= new Chord3(329.63, 440.0, 554.37);

  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
}

void draw() {
  background(#f4f4f4);
  image(base, width/2.0, height/2.0);
  if (bThumb) {
    image(thumb, width/2.0, height/2.0);
  }
  if (bIndex) {
    image(index, width/2.0, height/2.0);
  }
  if (bMiddle) {
    image(middle, width/2.0, height/2.0);
  }
  if (bRing) {
    image(ring, width/2.0, height/2.0);
  }
  if (bPinky) {
    image(pinky, width/2.0, height/2.0);
  }
}

void keyPressed() {

  SineWave mySine;
  MyNote newNote1;
  MyNote newNote2;
  MyNote newNote3;

  float pitch1 = 0;
  float pitch2 = 0;
  float pitch3 = 0;

  if (key == CODED) {
    switch(keyCode) {
      // III
    case LEFT : 
      bIndex = true;
      switch(octave) {
      case 0:
        pitch1 = iii_E_0.pitch1;
        pitch2 = iii_E_0.pitch2;
        pitch3 = iii_E_0.pitch3;
        break;
      case 1:
        pitch1 = iii_E_1.pitch1;
        pitch2 = iii_E_1.pitch2;
        pitch3 = iii_E_1.pitch3;
        break;
      case 2:
        pitch1 = iii_E_2.pitch1;
        pitch2 = iii_E_2.pitch2;
        pitch3 = iii_E_2.pitch3;
        break;
      }
      break;
      // IV
    case UP : 
      bMiddle = true;
      switch(octave) {
      case 0:
        pitch1 = iv_F_0.pitch1;
        pitch2 = iv_F_0.pitch2;
        pitch3 = iv_F_0.pitch3;
        break;
      case 1:
        pitch1 = iv_F_1.pitch1;
        pitch2 = iv_F_1.pitch2;
        pitch3 = iv_F_1.pitch3;
        break;
      case 2:
        pitch1 = iv_F_2.pitch1;
        pitch2 = iv_F_2.pitch2;
        pitch3 = iv_F_2.pitch3;
        break;
      }
      break;
      // V
    case RIGHT : 
      bRing = true;
      switch(octave) {
      case 0:
        pitch1 = v_G_0.pitch1;
        pitch2 = v_G_0.pitch2;
        pitch3 = v_G_0.pitch3;
        break;
      case 1:
        pitch1 = v_G_1.pitch1;
        pitch2 = v_G_1.pitch2;
        pitch3 = v_G_1.pitch3;
        break;
      case 2:
        pitch1 = v_G_2.pitch1;
        pitch2 = v_G_2.pitch2;
        pitch3 = v_G_2.pitch3;
        break;
      }
      break;
      // VI
    case DOWN :
      bPinky = true;
      switch(octave) {
      case 0:
        pitch1 = vi_A_0.pitch1;
        pitch2 = vi_A_0.pitch2;
        pitch3 = vi_A_0.pitch3;
        break;
      case 1:
        pitch1 = vi_A_1.pitch1;
        pitch2 = vi_A_1.pitch2;
        pitch3 = vi_A_1.pitch3;
        break;
      case 2:
        pitch1 = vi_A_2.pitch1;
        pitch2 = vi_A_2.pitch2;
        pitch3 = vi_A_2.pitch3;
        break;
      }
      break;
    default : 
      //pitch1 = 0;
      //pitch2 = 0;
      //pitch3 = 0;
      break;
    }
  } else if (key == ' ') {
    bThumb = true;
    octave = (octave + 1) % 3;
    println(octave);
  }

  if (pitch1 > 0 || pitch2 > 0 || pitch3 > 0) {
    newNote1 = new MyNote(pitch1, 0.1);
    newNote2 = new MyNote(pitch2, 0.1);
    newNote3 = new MyNote(pitch3, 0.1);
  }
}

void stop()
{
  out.close();
  minim.stop();

  super.stop();
}

void keyReleased() {
  bThumb = false;
  bIndex = false;
  bMiddle = false;
  bRing = false;
  bPinky = false;
}
