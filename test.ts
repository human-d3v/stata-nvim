import * as fs from "fs";

const filePath = "./commands.json";

let syntax:string [] = [];
try {
	const jsonStr = fs.readFileSync(filePath, 'utf8');
	const jsonObj = JSON.parse(jsonStr);
	syntax = jsonObj.syntax;
} catch (err){
	console.error("error in parsing JSON:", err);
}

let completion:object = syntax.filter((wd) => {
		return wd.startsWith('dis')})
	.slice(0,1000).map((wd)=>{
		return {label: wd}
	});

console.log(completion);
