from my_app import app

server = app.server
app.run(host="0.0.0.0", port=10000, debug=True)
