#Class representing a process to be executed

class Process
  @id: ""
  @algorithmIdentifier: ""
  @executableType: ""
  @req: null
  @method: ""
  @image: null
  @rootFolder: ""
  @outputFolder: ""
  @methodFolder: ""
  @neededParameters: null
  @inputParameters: null
  @inputHighlighters: null
  @inputFolder: ""
  @parameters: null
  @programType: ""
  @executablePath: ""
  @resultHandler: null
  @resultType: ""
  @resultFile: ""
  @tmpResultFile: ""
  @requireOutputImage: true
  @inputImageUrl: ""
  @outputImageUrl: ""
  @result: null
  @resultLink: ""
  @data: null
  @remoteResultUrl: ""
  @remotePaths: []
  @type: ""


  @hasFiles = false
  @hasImages = false

module.exports = Process