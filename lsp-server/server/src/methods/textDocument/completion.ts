import { RequestMessage } from "../../server";
import { documents, TextDocumentIdentifier } from "../../documents";
import * as fs from "fs";
import * as path from 'path';
import * as os from 'os';

// const words = fs.readFileSync("/usr/share/dict/words").toString().split('\n');
let syntax:any = [];
const filePath = path.join(os.homedir(), '.local', 'share', 'nvim', 'lazy', 
													 'stata-nvim', 'lsp-server', 'commands_updated.json')

enum SyntaxType {
	BETA_NONCENTRAL = 'beta-noncentral',
	BINOMIAL = 'binomial',
	CAUCHY = 'cauchy',
	CHI_SQUARE = 'chi-square',
	COMMAND = 'command',
	DATETIME = 'datetime',
	DUNNETT = 'dunnett',
	EXPONENTIAL = 'exponential',
	F_DISTRO = 'f-distro',
	GAMMA = 'gamma',
	HYPERGEOMETRIC = 'hypergeometric',
	INV_GAUSSIAN = 'inv-gaussian',
	LAPLACE = 'laplace',
	LOGISTIC = 'logistic',
	MATH = 'math', 
	MATRIX = 'matrix',
	NORMAL = 'normal',
	NEG_BINOMIAL = 'neg-binomial',
	POISSON = 'poisson',
	PROGRAMMING = 'programming',
	RANDOM = 'random',
	SCALAR = 'scalar',
	STRING_FUNC = 'string-func',
	STUDENT_T = 'student-t',
	TIME_SERIES = 'time-series',
	TRIG = 'trig',
	TURKEY = 'turkey',
	WEIBULL = 'weibull',
	WEIBULL_PROP = 'weibull-prop',
	WISHART = 'wishart',
}

interface SyntaxObject {
	command: string;
	type: SyntaxType;
}

try {
	const jsonStr = fs.readFileSync(filePath, {encoding:'utf8'});
	const jsonObj = JSON.parse(jsonStr);
	// syntax = jsonObj.syntax;
	syntax = jsonObj.syntax.array.map();
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
	const items = syntax.filter((wd:string) => {
		return wd.startsWith(currentPrefix)
	})
	.slice(0,1000)
	.map((wd:string)=>{
		let formattedWd: string = wd.replace(/_/g, ' ');
		return {label: formattedWd};
	})
	
	return {
		isIncomplete: true, 
		items,
	};
};
