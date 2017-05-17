// подключаем express
var express = require("express");
const PORT = process.env.PORT || 5000;

// создаем объект приложения
var app = express()

app.use(express.static(__dirname));
app.use("/img", express.static(__dirname + "/img"));

// обработчик для маршрута '/'
app.get("/", function(request, response){
    if(!request.query) {
        return response.sendStatus(400);
    }
    response.sendStatus(200);
})

// listen port 3000
app.listen(PORT, function(){
    console.log(`Start - OK! Listening port ${PORT}! %s mode`, app.settings.env)
});