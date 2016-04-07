config	= require('../../config/all.json')

util		= require('util')
Slack		= require('slack-node')

slack 	= new Slack("xoxp-2484893673-11688680993-32745169284-ade6aa278b")

module.exports = Files =

	delete: (between, types)->
		console.log "slack", slack
		console.log "types", types
		console.log "between", between

		slack.api 'files.list', { types: types, ts_from: between.ts_from, ts_to: between.ts_to }, (err, response) =>
			if response.files.length < 1
				console.log "no files to delete"
			else
				for file in response.files
					console.log "file.id", file.id
					slack.api 'files.delete', { file: file.id }, (err, response) ->
						console.log "deleted", response
