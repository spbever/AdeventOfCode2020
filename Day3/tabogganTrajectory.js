let fs = require('fs');
let treeMarker = '#';
let paths = [[3,1], [1,1],[5,1],[7,1],[1,2]]; //columns,rows
let rows = fs.readFileSync('./day3input.txt').toString().split("\n");

var treeCounters = [];

for(pathIndex in paths){
	var treeCounter = 0;
	var path = paths[pathIndex];
	var rowIndex = 0;
	var columnIndex = 0;

	while(rowIndex < rows.length) {
		if(rows[rowIndex][columnIndex % rows[rowIndex].length] == treeMarker) {
			treeCounter += 1
		}
		columnIndex += path[0];
		rowIndex += path[1];
	}

	if(pathIndex == 0){
		console.log("(Part 1) Trees encountered from path:" + treeCounter);
	}
	
	treeCounters.push(treeCounter);	
}
let productOfTreesEncountered = treeCounters.reduce(function(total, currentValue){ return total * currentValue; }, 1);
console.log("(Part 2) Product of trees encountered from paths:" + productOfTreesEncountered);
