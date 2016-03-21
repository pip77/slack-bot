config	= require('../../config/all.json')

util			= require('util')	
SlackBot	= require('slackbots')
Slack		= require('slack-node')

slack 		= new Slack(config.slack.token)
slackBot	= new SlackBot({
		token: config.bot.cleaner.token
		name: config.bot.cleaner.name
	})

module.exports = Cleaner =

	run: ()->
		slackBot.on 'message', (msg)=>
			if @isChatMessage(msg)
				trigger = new RegExp(config.bot.cleaner.trigger)
				if trigger.test(msg.text.toLowerCase()) and @isFromMe(msg)
					console.log "also"
					slack.api 'files.list', { types: 'images,snippets' }, (err, response) =>
						if response.files.length < 1
							slackBot.postMessageToChannel config.bot.cleaner.channel, config.bot.cleaner.msg.nothing
						else
							@deleteFiles(response.files)
						return
			return
			
	isChatMessage: (msg)->
		console.log "isChatMessage?"
		msg.type == 'message' and !msg.deleted_ts?

	isFromMe: (msg)->
		console.log "isFromMe?"
		name = new RegExp(slackBot.name)
		name.test(msg.text.toLowerCase())

	deleteFiles: (files)->
		console.log "deleteFiles!"
		i = 0
		while i < files.length
			slack.api 'files.delete', { file: files[i].id }, (err, response) ->
				return
			if i == files.length - 1
				bot.postMessageToChannel config.bot.cleaner.channel, config.bot.cleaner.msg.done
			i++
