import terrylib.*;

class Main {
	function new() {
	  var test:Array<String> = [];
		
		test = Data.loadcsv("test");
		
		for (j in 0 ... Data.height) {
			for (i in 0 ... Data.width) {
				trace(i, j, test[i + (j * Data.width)]);
			}
		}
	}
	
	function update() {
		
  }
}