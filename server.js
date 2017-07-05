// подключаем express
var express = require("express"),
    nodemailer = require('nodemailer'),
    xAdmin = require("express-admin"),
    nodemailer = require('nodemailer'),
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
    app.get('/mail', function (req, res) {
        console.log('******')
        console.log('req', req)

    // create reusable transporter object using the default SMTP transport
    let transporter = nodemailer.createTransport({
        host: 'smtp.mail.ru',
        port: 465,
        secure: true, // secure:true for port 465, secure:false for port 587
        auth: {
            user: 'dimon009@list.ru',
            pass: 's4qtm8652'
        }
    });

    // setup email data with unicode symbols
    let mailOptions = {
        from: '"dimon009@list.ru', // sender address
        to: 'dimon009@list.ru', // list of receivers
        subject: 'Hello ✔', // Subject line
        text: 'Call', // plain text body
    };

    // send mail with defined transport object
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message %s sent: %s', info.messageId, info.response);
    });
    });
    // site server
    app.listen(PORT, function () {
        console.log(`Start - OK! Listening port ${PORT}! %s mode`, app.settings.env)
    });
});