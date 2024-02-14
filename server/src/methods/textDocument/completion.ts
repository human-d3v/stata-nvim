import { RequestMessage } from "../../server";
import { documents, TextDocumentIdentifier } from "../../documents";
import * as fs from "fs";

// const words = fs.readFileSync("/usr/share/dict/words").toString().split('\n');

const filePath = "../../../../commands.json";
let syntax = [];
try {
	const jsonStr = fs.readFileSync(filePath, 'utf8');
	const jsonObj = JSON.parse(jsonStr);
	syntax = jsonObj.syntax;
} catch (err) {
	console.error("error parsing JSON",err);
}

type CompletionItem = {
	label: string;
};

export interface CompletionList {
	isIncomplete: boolean;
	items: CompletionItem[];
}

interface Position {
	line: number;
	character: number;
};


interface TextDocumentCompletionParams {
	textDocument: TextDocumentIdentifier;
	position:			Position;
};

export interface CompletionParams extends TextDocumentCompletionParams {
	
};

export const completion = (message: RequestMessage): CompletionList | null=> {
	const params = message.params as CompletionParams;
	const  content = documents.get(params.textDocument.uri);
	if (!content) {
		return null;
	}
	const currentLine = content.split("\n")[params.position.line];
	const lineUntilCursor = currentLine.slice(0, params.position.character);
	const currentPrefix = lineUntilCursor.replace(/.*\W(.*?)/, "$1");
	const items = words.filter((wd) => {
		return wd.startsWith(currentPrefix)
	})
	.slice(0,1000)
	.map((wd)=>{
		return {label: wd};
	})
	
	return {
		isIncomplete: true, 
		items,
	};
};
