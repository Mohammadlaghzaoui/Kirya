const http = require('http');
const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..', 'deploy');
const types = {'.html':'text/html; charset=utf-8','.css':'text/css','.js':'application/javascript','.png':'image/png','.json':'application/json'};
http.createServer((req,res)=>{
  let p = decodeURIComponent(req.url.split('?')[0]);
  if (p === '/' || p === '') p = '/index.html';
  let file = path.join(root, p);
  if (!fs.existsSync(file) || fs.statSync(file).isDirectory()) file = path.join(root,'index.html');
  fs.readFile(file,(e,data)=>{
    if(e){res.writeHead(500);res.end('error');return;}
    res.writeHead(200,{'Content-Type':types[path.extname(file)]||'text/plain'});
    res.end(data);
  });
}).listen(8080,'0.0.0.0',()=>console.log('Kirya server running on http://0.0.0.0:8080'));
