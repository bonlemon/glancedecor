const nodemailer = require('nodemailer');

// create reusable transporter object using the default SMTP transport
let transporter = nodemailer.createTransport({
    host: 'smtp.example.com',
    port: 465,
    secure: true, // secure:true for port 465, secure:false for port 587
    auth: {
        user: 'dimon009@list.ru',
        pass: 'userpass'
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