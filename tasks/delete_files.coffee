files = require("../lib/scripts/files")

ts_to = new Date()
ts_to = ts_to.setMonth(ts_to.getMonth() - 1)
ts_to = Math.floor(ts_to / 1000)

between =
	ts_from: 0
	ts_to: ts_to

module.exports.deleteFiles = (options)->
	# Load after the environment has been set
	files = require("../lib/scripts/files")

	files.delete(between, "all")
