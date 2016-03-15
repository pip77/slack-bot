var config = require('./config/all.json');

var SlackBot = require('slackbots');
var Slack = require('slack-node');

slack = new Slack(config.slack.token.api);
var bot = new SlackBot({
    token: config.slack.token.bot,  
    name: config.slack.botsName
});
 
bot.on('start', function() {
    console.log(bot.self.id); 
});

bot.on('message', function(message) {
    if(message.type == "message") {
        if(message.text.toLowerCase().indexOf(config.slack.trigger) > -1 && message.text.toLowerCase().indexOf(bot.name) > -1) {
            console.log("Do it, have I?");

            slack.api("files.list", {
              types:'images,snippets'
            }, function(err, response) {
              console.log(response.files);

              if(response.files.length < 1) {
                bot.postMessageToChannel(config.slack.channel, config.slack.msg.nothing);
              } else {
                for(var i=0; i < response.files.length; i++) {
                    console.log(i);
                    console.log(response.files[i]);
    
                    slack.api("files.delete", {
                      file: response.files[i].id
                    }, function(err, response) {
                        console.log(response);
                    });
    
                    if(i == response.files.length-1)
                        bot.postMessageToChannel(config.slack.channel, config.slack.msg.done);
                    }
                }
            });
        }
    }
});
