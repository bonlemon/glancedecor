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

function sendMail(subject, text){
    // create reusable transporter object using the default SMTP transport
        let transporter = nodemailer.createTransport({
            host: 'smtp.mail.ru',
            port: 587,
            secure: false, // upgrade later with STARTTLS
            auth: {
                user: 'glancedecor@mail.ru',
                pass: 'wow1050525'
            }
        });

        // setup email data with unicode symbols
        let mailOptions = {
            from: 'glancedecor@mail.ru', // sender address
            to: 'glancedecor@mail.ru', // list of receivers
            subject: subject, // Subject line
            text: text, // plain text body
        };

        // send mail with defined transport object
        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                return console.log(error);
            } else{
                console.log('Message %s sent: %s', info.message);
            }
        });
}

xAdmin.init(config, function (err, admin) {
    if (err) return console.log(err);
    // web site
    var app = express();

    app.use('/admin', admin);
    app.use('/', express.static(__dirname));
    // site routes
    app.get('/mail', function (req, res) {
        sendMail('Call me! ✔', req.query.phone)
    });

    app.get('/feedback', function (req, res) {
        // generate body of message
        var textForMail = `Имя: ${req.query.name} \ne-mail: ${req.query.email} \nтелефон: ${req.query.phone} \nСообщение: ${req.query.text}`
        sendMail('Feedback! ✔', textForMail)
    });
    // site server
    app.listen(PORT, function () {
        console.log(`Start - OK! Listening port ${PORT}! %s mode`, app.settings.env)
    });
});