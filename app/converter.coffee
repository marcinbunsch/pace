class Converter

  convertPaceToKph: (paceInSeconds) =>
    kph = 3600 / paceInSeconds
    Math.floor(kph * 100) / 100

  convertKphToPace: (kph) ->
    pace = if kph > 0 then (60 / kph) else 0
    minutes = Math.floor(pace)
    seconds = Math.floor(60*(pace - minutes))
    return minutes * 60 + seconds

  convertPaceToString: (paceInSeconds) ->
    minutes = Math.floor(paceInSeconds / 60)
    seconds = Math.floor(paceInSeconds - minutes * 60)
    seconds = "0" + seconds if (seconds < 10)
    [minutes, seconds].join(':')

  convertKphToPaceString: (kph) ->
    pace = this.convertKphToPace(kph)
    this.convertPaceToString(pace)

module.exports = Converter

