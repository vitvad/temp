function initMain(){
	var options = {
		field: "field"
	}
	var field = {
		canvas: document.getElementById(options.field),
		ctx: document.getElementById(options.field).getContext("2d"),
	}

	field.ctx.beginPath();
	drawCircle(field.ctx ,{x:150, y:75, r:50});
	field.ctx.lineWidth = 5;
	field.ctx.strokeStyle = "#0f0";
	field.ctx.stroke();
	//init()
}

function drawCircle(context, pos) {
	context.arc(pos.x, pos.y, pos.r, 0, 2 * Math.PI, false);
}

function drawTrangle(context, pos){
	context.arc(pos.x, pos.y, pos.r, 0, 2 * Math.PI, false);
}

if (window.addEventListener) window.addEventListener("load", initMain, false);
else if (window.attachEvent) window.attachEvent("onload", initMain);



// функция рисует под углом angle линию из указанной точки длиной ln
function drawLine(x, y, ln, angle) {
	context.moveTo(x, y);
	context.lineTo(Math.round(x + ln * Math.cos(angle)), Math.round(y - ln * Math.sin(angle)));
}
// Функция рисует дерево
function drawTree(x, y, ln, minLn, angle) {
	if (ln > minLn) {
		ln = ln * 0.75;
		drawLine(x, y, ln, angle);
		x = Math.round(x + ln * Math.cos(angle));
		y = Math.round(y - ln * Math.sin(angle));
		drawTree(x, y, ln, minLn, angle + Math.PI/12);
		drawTree(x, y, ln, minLn, angle - Math.PI/12);
		// если поставить угол Math.PI/4 , то выйдет классическое дерево
	}
}
// Инициализация переменных
function init() {
	var canvas = document.getElementById("field");
	context = canvas.getContext("2d");
	canvas.width = 480; // Ширина холста
	canvas.height = 320; // высота холста
	var x = canvas.width / 2;
	var y = canvas.height;
	var ln = 20; // начальная длина линии
	var minLn = 4; // минимальная длина до которой рисуются линии
	context.fillStyle = "#ddf"; // цвет фона
	context.strokeStyle = "#020"; //цвет линий
	context.fillRect(0, 0, canvas.width, canvas.height);
	context.lineWidth = 2; // ширина линий
	context.beginPath();
	drawTree(x, y, ln, minLn, Math.PI / 2);
	context.stroke();
}