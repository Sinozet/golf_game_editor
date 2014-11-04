int[][][] shapes, shapes2;
int[][] enemy;
int[] start, finish;
int count = 0, vert = 0, enemies = 0;
boolean setStart = false, setFinish = false, setEnemy = false, setWall=true;

void setup() {
	shapes = new int[100][100][2];
	start = new int[2];
	finish = new int[2];
	enemy = new int[100][2];
	start[0] = 20; start[1] = 20;
	finish[0] = 60; finish[1] = 60;
	size(640,360);
	smooth();
	stroke(120);
	fill(60);
	strokeWeight(4);
	background(0);
}

void draw() {
	background(0);
	for (int i = 0; i <= count; i++) {

		if(i<count) {
			fill(30,120,30);
		}
		else fill(60);

		beginShape();
		for (int k = 1; k <= shapes[i][0][0]; k++) {
			vertex(shapes[i][k][0], shapes[i][k][1]);
		}
		endShape(CLOSE);
	}

	for (int i = 1; i <= enemies; i++) {
		fill(220,0,0);
		ellipse(enemy[i][0], enemy[i][1], 30, 30);
	}

	if (setStart) {
		fill(0,220,0);
		ellipse(mouseX, mouseY, 20, 20);
	}
	else if (setFinish) {
		fill(0,0,220);
		ellipse(mouseX, mouseY, 20, 20);
	}
	else if (setEnemy) {
		fill(220,0,0);
		ellipse(mouseX, mouseY, 20, 20);
	}

	fill(0,220,0);
	ellipse(start[0], start[1], 30, 30);
	fill(0,0,220);
	ellipse(finish[0], finish[1], 30, 30);

}

void mousePressed() {
	if (setWall) {
		vert++;
		shapes[count][0][0] = vert;
		shapes[count][vert][0] = mouseX;
		shapes[count][vert][1] = mouseY;
	}
	if (setEnemy) {
		enemies++;
		enemy[0][0] = enemies;
		enemy[enemies][0] = mouseX;
		enemy[enemies][1] = mouseY;
	}
	else if (setStart) {
		start[0] = mouseX;
		start[1] = mouseY;
	}
	else if (setFinish) {
		finish[0] = mouseX;
		finish[1] = mouseY;
	}
}

void setArrays() {
	JSONArray walls = new JSONArray();
	for (int i = 0; i <= count; i++) {
		JSONArray vertxs = new JSONArray();
		JSONObject wall = new JSONObject();
	
		for (int k = 1; k <= shapes[i][0][0]; k++) {
			JSONObject vertx = new JSONObject();
			vertx.setInt("x",shapes[i][k][0]);
			vertx.setInt("y",shapes[i][k][1]);
			vertxs.setJSONObject(k-1,vertx);
		}
		wall.setJSONArray("vertices", vertxs);
		walls.setJSONObject(i, wall);
	}		

	saveJSONArray(walls, "level.txt");
}


void keyPressed() {
	if (key == ENTER) {
		count++;
		vert = 0;
	}

	else if (key == TAB) {
		setArrays();
	}

	else if (key == BACKSPACE) {
		shapes2 = new int[100][100][2];
		count--;
		for (int i = 0; i <= count; i++) {
			shapes2[i] = shapes[i];
		}
		shapes = shapes2;
	}
	if (key == CODED) {
		if (keyCode == UP) {
			setStart = true;
			setFinish = false;
			setEnemy = false;
			setWall=false;
		} else if (keyCode == DOWN) {
			setStart = false;
			setFinish = true;
			setEnemy = false;
			setWall=false;
		} else if (keyCode == LEFT) {
			setStart = false;
			setFinish = false;
			setEnemy = true;
			setWall=false;
		} else if (keyCode == RIGHT) {
			setStart = false;
			setFinish = false;
			setEnemy = false;
			setWall=true;
		}
	}

}