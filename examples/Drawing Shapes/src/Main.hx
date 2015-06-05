import terrylib.*;

class Main {
	var currenteffect:Int;    // Current effect we're drawing on the screen
	var totaleffects:Int;     // Total number of effects
	
	var counter:Int;          // Count up one every frame: using in this program for animation.
	
	var pulse:Int;            // A variable that counts from 0 to 50 and back.
	var pulsedir:String;      // Controls the direction of the pulse.
	
	// new() is a special function that is called on startup.
	function new() {
		currenteffect = 1;
		totaleffects = 4;
		
		pulse = 0;
		counter = 0;
		pulsedir = "up";
		
		//Set up the triangle buffer
		Gfx.createimage("triangles", Gfx.screenwidth, Gfx.screenheight);
		drawtriangles(1);
	}
	
	function update() {
		if (Mouse.leftclick()) {
			currenteffect = currenteffect + 1;
			if (currenteffect > totaleffects) currenteffect = 1;
		}
		
		counter++;
		if (pulsedir == "up") {
			pulse++;
			if (pulse >= 50) pulsedir = "down";
		}else if (pulsedir == "down") {
			pulse--;
			if (pulse <= 0)	pulsedir = "up";
		}
		
		if (currenteffect == 1) {
			drawtriangles(currenteffect);
		}else if (currenteffect == 2) {
			drawcircles(currenteffect);
		}else if (currenteffect == 3) {
			drawhexagon(currenteffect);
		}else if (currenteffect == 4) {
			drawstripes(currenteffect);
		}
		
		Text.changesize(16);
		//Display the text twice, once black and slightly offset, once white to give a shadow effect under the string
		Text.display(Gfx.screenwidth - 10 +2, Gfx.screenheight - Text.height() - 5 + 2, "LEFT CLICK MOUSE TO CYCLE EFFECTS", Col.BLACK, { rightalign: true } );
		Text.display(Gfx.screenwidth - 10, Gfx.screenheight - Text.height() - 5, "LEFT CLICK MOUSE TO CYCLE EFFECTS", Col.WHITE, { rightalign: true } );
	}
	
	function drawtriangles(effectnum:Int) {
		//Draw to a specially made image buffer
		Gfx.drawtoimage("triangles");
		
		if (counter % 60 == 0) {
			//Clear the screen every second
			Gfx.fillbox(0, 0, Gfx.screenwidth, Gfx.screenheight, Col.NIGHTBLUE, 0.9);
		}
		
		//Draw a triangle with random vertices, random colour and alpha of 0.6.
		Gfx.filltri(Random.int(0, Gfx.screenwidth), Random.int(0, Gfx.screenheight), Random.int(0, Gfx.screenwidth), Random.int(0, Gfx.screenheight), Random.int(0, Gfx.screenwidth), Random.int(0, Gfx.screenheight), Gfx.HSL(Random.int(0, 360), 0.5, 0.5), 0.6);
		
		//Draw that buffer to the screen
		Gfx.drawtoscreen();
		Gfx.drawimage(0, 0, "triangles");
		
		Text.changesize(16);
		//Display the text twice, once black and slightly offset, once white to give a shadow effect under the string
		Text.display(10 +2, Gfx.screenheight - Text.height() - 5 + 2, effectnum + ": TRIANGLES", Col.BLACK);
		Text.display(10, Gfx.screenheight - Text.height() - 5, effectnum + ": TRIANGLES", Col.WHITE);
	}
	
	function drawcircles(effectnum:Int) {
		Gfx.setlinethickness(3);
		var radius:Int = 0;
		
		radius = (counter % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.RED);
		radius = ((counter+20) % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.YELLOW);
		radius = ((counter+40) % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.ORANGE);
		radius = ((counter+60) % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.YELLOW);
		radius = ((counter+80) % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.WHITE);
		radius = ((counter+100) % 120) * 4;
		Gfx.drawcircle(Gfx.screenwidthmid, Gfx.screenheightmid, radius, Col.ORANGE);
		
		Text.changesize(16);
		//Display the text twice, once black and slightly offset, once white to give a shadow effect under the string
		Text.display(10 +2, Gfx.screenheight - Text.height() - 5 + 2, effectnum + ": CIRCLES", Col.BLACK);
		Text.display(10, Gfx.screenheight - Text.height() - 5, effectnum + ": CIRCLES", Col.WHITE);
	}
	
	function drawhexagon(effectnum:Int) {
		Gfx.setlinethickness(2);
			
		for (i in 0 ... 30) {
			Gfx.drawhexagon(Gfx.screenwidthmid, Gfx.screenheightmid, 10 + (i*20) + (pulse / 2), counter / 50, Gfx.RGB(255-(8*i), 255-(8*i), 255-(8*i)));
		}
		
		Text.changesize(16);
		//Display the text twice, once black and slightly offset, once white to give a shadow effect under the string
		Text.display(10 +2, Gfx.screenheight - Text.height() - 5 + 2, effectnum + ": HEXAGON", Col.BLACK);
		Text.display(10, Gfx.screenheight - Text.height() - 5, effectnum + ": HEXAGON", Col.WHITE);
	}
	
	function drawstripes(effectnum:Int) {
		var colour1:Int;
		var colour2:Int;
		
		if (counter % 60 < 20) {
			colour1 = Col.GRAY;
			colour2 = Col.WHITE;
		}else if (counter % 60 < 40) {
			colour1 = Col.RED;
			colour2 = Col.YELLOW;
		}else {
			colour1 = Col.GREEN;
			colour2 = Col.LIGHTBLUE;
		}
		
		if (counter % 120 < 60) {
			//Horizontal stripes
			for (stripe in 0 ... 20) {
				Gfx.fillbox(0, ( -(counter % 20) * 4) + (stripe * 40), Gfx.screenwidth, 20, colour1);
				Gfx.fillbox(0, ( -(counter % 20) * 4) + (stripe * 40) + 20, Gfx.screenwidth, 20, colour2);
			}
		}else {
			//Vertical stripes
			for (stripe in 0 ... 24) {
				Gfx.fillbox(( -(counter % 20) * 4) + (stripe * 40), 0, 20, Gfx.screenheight, colour1);
				Gfx.fillbox(( -(counter % 20) * 4) + (stripe * 40) + 20, 0, 20, Gfx.screenheight, colour2);
			}
		}
		
		Text.changesize(16);
		//Display the text twice, once black and slightly offset, once white to give a shadow effect under the string
		Text.display(10 +2, Gfx.screenheight - Text.height() - 5 + 2, effectnum + ": STRIPES", Col.BLACK);
		Text.display(10, Gfx.screenheight - Text.height() - 5, effectnum + ": STRIPES", Col.WHITE);
	}
}
