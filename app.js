var Stream = require('node-rtsp-stream')
var stream = new Stream({
    name: 'pond',
    streamUrl: 'rtsp://10.101.2.159:554/0',
    wsPort: 9999
})

var finalhandler = require('finalhandler')
var http = require('http')
var serveStatic = require('serve-static')

// Serve up public/ftp folder
var serve = serveStatic('public')

// Create server
var server = http.createServer(function(req, res){
  var done = finalhandler(req, res)
  serve(req, res, done)
})

// Listen
server.listen(3000)
console.log("Server listening on: 3000")
console.log("If blank find IP of MAC: 00-0b-82-6f-06-eb")
