var port = process.env.NODE_PORT || 3000
var http = require('http')

var server = http.createServer((req, res) => {
  console.log(req.headers)
  
  res.statusCode = 200
  res.setHeader('Content-Type', 'text/plain')
  res.end('Test Service\n')
})

server.listen(port, () => {
  console.log('listening on port: ' + port)
})
