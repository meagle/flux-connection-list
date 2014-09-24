var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var _ = require('underscore');
var routes = require('./routes/index');
var users = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


var server = require('http').Server(app);
var io = require('socket.io')(server);
server.listen(3001);

var presenceGenerationInterval = null;
var batchInterval = null;

var presenceUpdates = [];

io.on('connection', function (socket) {
  socket.emit('connected', { msg: 'Hello socket user!' });
  socket.on('start:presence:storm', function (data) {
    presenceGenerationInterval = setInterval(function(){
      // update presence for random user
      userId = _.random(0, 649);
      presences = ['online', 'away', 'offline']
      presenceUpdates.push({userId: userId, presence: presences[_.random(0, 2)]});
    }, 50);

    batchInterval = setInterval(function () {
      socket.emit('presence:update', presenceUpdates);
      presenceUpdates.length = 0;
    }, 200);
    
  });

  socket.on('stop:presence:storm', function (data){
    clearInterval(presenceGenerationInterval);
    clearInterval(batchInterval);
  })
});

app.use('/', routes);
app.use('/users', users);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});


module.exports = app;
