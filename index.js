// подключаем express
var express = require("express");

// создаем объект приложения
var app = express()

app.use(express.static('./'));

// обработчик для маршрута '/'
app.get("/", function(request, response){
    if(!request.query) {
        return response.sendStatus(400);
    }
    response.sendStatus(200);
})

// listen port 3000
app.listen(3000, function(){
    console.log('Start - OK! Listening port 3000!')
});