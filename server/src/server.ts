import log from './log';
import { initialize } from './methods/initialize';
import { completion } from './methods/textDocument/completion';
import { didChange } from './methods/textDocument/didChange';

interface Message {
	jsonrpc: string;
};

export interface NotificationMessage extends Message {
	method: string;
	params?: unknown[] | object;
};

export interface RequestMessage extends NotificationMessage {
	id: number | string;
};


type RequestMethod = (
	message: RequestMessage
) => ReturnType<typeof initialize> | ReturnType<typeof completion>;

type NotificationMethod = (message: NotificationMessage) => void;


const methodLookup: Record<string, RequestMethod | NotificationMethod> = {
	initialize,
	"textDocument/completion": completion,
	"textDocument/didChange": didChange,
};

const respond = (id: RequestMessage['id'], result:object | null) => {
	const msg = JSON.stringify({id, result});
	const messageLength = Buffer.byteLength(msg, "utf-8");
	const header = `Content-Length: ${messageLength}\r\n\r\n`;
	log.write(header+msg);
	process.stdout.write(header+msg);
};

/*
	the chunk passed into the following function contains a json payload as well 
	as a content header and an additional \n character. By initializizing buf
	outside of the function, the json object can be parsed from the additional
	characters using a regex 
*/
let buf = ''; 

process.stdin.on("data", (chunk) =>{
	buf += chunk; 
	while (true) {
		// check for content length line
		const lengthMatch = buf.match(/Content-Length: (\d+\)\r\n/);
		if(!lengthMatch) break;
		const contentLength = parseInt(lengthMatch[1], 10);
		const messageStart = buf.indexOf("\r\n\r\n") + 4;
		// continue unless full msg is in buf
		if (buf.length < messageStart + contentLength) break;
		const rawMsg = buf.slice(messageStart, messageStart+contentLength);
		const message = JSON.parse(rawMsg);
		log.write({id: message.id, method: message.method});
		// call method and respond
		const method = methodLookup[message.method];
		if (method) {
			const result = method(message);
			if(result!== undefined){
				respond(message.id, result);
			}
		}

		// Remove the processed message from buffer
		buf = buf.slice(messageStart, messageStart+contentLength);
	}
});

