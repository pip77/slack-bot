Files = require("./lib/scripts/files")

ts_to = new Date()
ts_to = ts_to.setMonth(ts_to.getMonth() - 1)

between =
	ts_from: 0
	ts_to: ts_to

Files.delete(between, "all")
