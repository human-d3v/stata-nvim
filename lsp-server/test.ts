import * as fs from "fs";

enum SyntaxType {
	function,
	option
}

interface SyntaxParams {
	command:string;
	syntaxType: SyntaxType;
	shortDescription: string;
	verboseDescription: string;
	syntaxSimple: string;
	syntaxVerbose: string;
	example: string;
  extendedCommand:string[];
}

const jsonString:string = fs.readFileSync("./commands2.json", "utf8");
const jsonData = JSON.parse(jsonString);


const combinedData:string[] = [];

jsonData.syntax.forEach((syn:SyntaxParams) => {
	combinedData.push(syn.command)
	syn.extendedCommand.forEach((ex:string) => {
		combinedData.push(ex)	
	})
});

console.log(combinedData);
