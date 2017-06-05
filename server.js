// подключаем express
var express = require("express"),
    xAdmin = require("express-admin"),
    config = {
        dpath: './admin',
	config: require('./admin/config.json'),
	settings: require('./admin/settings.json'),
	custom: require('./admin/custom.json'),
	users: require('./admin/users.json')
    };

const PORT = process.env.PORT || 5001;

xAdmin.init(config, function (err, admin) {
    if (err) return console.log(err);
    // web site
    var app = express();

    app.use('/admin', admin);
    app.use('/', express.static(__dirname));
    // site routes
    app.get('/', function (req, res) {
        res.send('Hello World');
    });
    // site server
    app.listen(PORT, function(){
        console.log(`Start - OK! Listening port ${PORT}! %s mode`, app.settings.env)
    });
});
