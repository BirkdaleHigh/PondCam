window.onload = function(){
    client = new WebSocket('ws://localhost:9999')
    player = new jsmpeg(client, {
        canvas: document.getElementById('video'),
        autoplay: true
    })
}