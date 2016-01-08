# IoHelper
# =======
#
# **IoHelper** provides helper methods for handling with files
#
# Copyright &copy; Marcel Würsch, GPL v3.0 licensed.

# Module dependecies
fs      = require 'fs'
nconf   = require 'nconf'
path    = require 'path'
_       = require 'lodash'
logger  = require '../logging/logger'


# expose IoHelper
ioHelper = exports = module.exports = class IoHelper

  getOutputFolder: (rootFolder, service) ->
    #check which folder is to be used
    imagePath = nconf.get('paths:imageRootPath')
    rootPath = imagePath + '/' + rootFolder
    #read all folders in the current directory
    folders = fs.readdirSync(rootPath).filter (file) ->
      fs.statSync(path.join(rootPath,file)).isDirectory()

    #filter for folders matching the service name
    folders = _.filter folders,  (folder) ->
      _.contains folder,service

    #TODO check

    if(folders.length > 0)
      numbers = _.invoke folders, String::split, '_'
      numbers = _.pluck(numbers, 1)
      maxNumber = parseInt(_.max(numbers),10)
      return rootPath + '/' + service + '_' + (maxNumber + 1)
    else
      return rootPath + '/' + service + '_0'

  #build file Path from outputFolder name and filename
  buildFilePath: (path, fileName) ->
    return path + '/' + fileName + '.json'

  buildTempFilePath: (path, fileName) ->
    return path + '/' + fileName + '_temp.json'

  # ---
  # **loadResult**</br>
  # Loads existing results from the disk</br>
  # `params`
  #   *filePath* path to the result file
  loadResult: (filePath) ->
    logger.log "info",'load from file  ' + filePath
    try
      fs.statSync(filePath)
      content = JSON.parse(fs.readFileSync(filePath,'utf8'))
      return content
    catch error
      return null

  # ---
  # **/br>
  # Saves the results of a method execution to the disk</br>
  # `params`
  #   *path*  path to the image folder, where results are stored
  #   *algorithm* the executed algorithm
  #   *params*  the used parameter values
  #   *result*  the execution result
  saveResult: (filePath, result, callback) ->
    fs.stat filePath, (err, stat) ->
      #check if file exists
      #console.log 'saving file to: ' + filePath
      fs.writeFile filePath, result,  (err) ->
        if err?
          error =
            status: 500
            statusText: 'Could not save result file'
          callback error, null
        else
          callback null, result
        return
    return


  writeTempFile: (filePath) ->
    try
      stats = fs.statSync filePath
        #check if file exists
        #console.log 'saving file to: ' + filePath
    catch error
      try
        fs.writeFileSync filePath, JSON.stringify({status :'planned'})
      catch error
        logger.log 'error', error

    return
