let WIDTH,HEIGHT;
const FRAMERATE = 60;


let particles;
let a = Math.random()*1000;
let balls = Math.pow(30,2);

function setup() {
  createCanvas(WIDTH, HEIGHT);
  frameRate(FRAMERATE);
	textAlign(CENTER)
	textFont('Georgia');
  
  particles = new Array(balls).fill(0).map((x,i) => new Particle(i))
  // console.log(particles)
  windowResized();
	background(0)
}

function draw() {
  background(0,0,0,10);

	fill(50,0,0);
	// rect(SQUARE_POS.x, SQUARE_POS.y, SQUARE_SIZE.x, SQUARE_SIZE.y)

	fill(0);
	rect(0,0,50,50);
	fill(200,0,0);
	textSize(13);
	text(round(frameRate())+" fps", 30, 20);

	fill(100,0,0);
	textSize(40);
	text("Redes de Comunicações I",WIDTH/2,70)


  stroke(100)
  for(let i=0;i<particles.length-1;i++){
    if(i%sqrt(balls) < sqrt(balls)-1)
      line(particles[i].dp.x,particles[i].dp.y,particles[i+1].dp.x,particles[i+1].dp.y)
    if(i/sqrt(balls) < sqrt(balls)-1)
      line(
        particles[i].dp.x,particles[i].dp.y,
        particles[i+sqrt(balls)].dp.x,particles[i+sqrt(balls)].dp.y
      );
  }
  particles.forEach(p => p.draw());
  a+=0.005;  
}

function windowResized(){
	WIDTH = window.innerWidth;
	HEIGHT = window.innerHeight;
	if(WIDTH>HEIGHT){
		SQUARE_POS = createVector((WIDTH-HEIGHT)/2+(WIDTH*0.2)/2, (HEIGHT*0.2)/2);
		SQUARE_SIZE = createVector(HEIGHT*0.8,HEIGHT*0.8);
	}
	else{
		SQUARE_POS = createVector((WIDTH*0.2)/2, (HEIGHT-WIDTH)/2+(WIDTH*0.2)/2);
		SQUARE_SIZE = createVector(WIDTH*0.8,WIDTH*0.8);
	}
	particles.forEach(p=>{
		p.p = createVector(
			SQUARE_POS.x + (SQUARE_SIZE.x/sqrt(balls))*(    p.i%sqrt(balls)),
			SQUARE_POS.y + (SQUARE_SIZE.y/sqrt(balls))*(int(p.i/sqrt(balls)))
		);
	})
	resizeCanvas(WIDTH,HEIGHT);
}


class Particle {
  constructor(i){
    this.i = i;
    // this.p = createVector(
    //   WIDTH *0.25+(WIDTH *0.5/sqrt(balls)) *(    i%sqrt(balls)),
    //   HEIGHT*0.25+(HEIGHT*0.5/sqrt(balls)) *(int(i/sqrt(balls)))
    // );
		this.p = createVector(0,0);
    this.dp = this.p;
  }
  
  draw(){
    let d = createVector(
      noise(a+   (this.i/sqrt(balls))*0.05)-0.5,
      noise(a+int(this.i%sqrt(balls))*0.05)-0.5
    );
		// console.log(d)
    d.mult(50);
    this.dp = createVector(this.p.x+d.x, this.p.y+d.y);
    
    noStroke();
    fill(170,0,0);
    ellipse(this.dp.x,this.dp.y,5,5);
  }
}
