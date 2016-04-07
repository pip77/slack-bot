
require('coffee-script/register')

deleteFiles = require("./tasks/delete_files")


option('-P', '--production', 'Apply to production environment')
option('-S', '--staging', 'Apply to staging environment')
option('-T', '--test', 'Apply to test environment')

task("delete:files", "Delete files", deleteFiles.deleteFiles)
