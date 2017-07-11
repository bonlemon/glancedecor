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

        // create reusable transporter object using the default SMTP transport
        let transporter = nodemailer.createTransport({
            host: 'smtp.mail.ru',
            port: 587,
            secure: false, // upgrade later with STARTTLS
            auth: {
                user: 'dimon009@list.ru',
                pass: '123'
            }
        });

        // setup email data with unicode symbols
        let mailOptions = {
            from: '"dimon009@list.ru', // sender address
            to: 'dimon009@list.ru', // list of receivers
            subject: 'Call me! ✔', // Subject line
            text: req.query.phone, // plain text body
        };

        // send mail with defined transport object
        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                return console.log(error);
            } else{
                console.log('Message %s sent: %s', info.message);
            }
        });
    });
    // site server
    app.listen(PORT, function () {
        console.log(`Start - OK! Listening port ${PORT}! %s mode`, app.settings.env)
    });
});