config 		= require('./config/all.json')
SlackBot 	= require('slackbots')
Slack 		= require('slack-node')

slack = new Slack (config.slack.token.api)
bot = new SlackBot (
	token: config.slack.token.bot
	name: config.slack.botsName
)

bot.on 'message', (message) ->
	if message.type == 'message' and !message.deleted_ts?
		if message.text.toLowerCase().indexOf(config.slack.trigger) > -1 and message.text.toLowerCase().indexOf(bot.name) > -1
			slack.api 'files.list', { types: 'images,snippets' }, (err, response) ->
				if response.files.length < 1
					bot.postMessageToChannel config.slack.channel, config.slack.msg.nothing
				else
					i = 0
					while i < response.files.length
						slack.api 'files.delete', { file: response.files[i].id }, (err, response) ->
							console.log response
							return
						if i == response.files.length - 1
							bot.postMessageToChannel config.slack.channel, config.slack.msg.done
						i++
				return
	return