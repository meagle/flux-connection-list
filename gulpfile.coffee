browserify = require("browserify")
watchify = require("watchify")
gulp = require("gulp")
source = require("vinyl-source-stream")
sourceFile = ".public/coffee/main.coffee"
destFolder = ".public/js/"
destFile = "bundle.js"

gulp.task "browserify", ->
  browserify(sourceFile)
    .transform(coffeeify)
    .bundle()
    .pipe(source(destFile))
    .pipe gulp.dest(destFolder)

gulp.task "watch", ->
  rebundle = ->
    bundler.bundle()
    .pipe(source(destFile))
    .pipe gulp.dest(destFolder)
    
  bundler = watchify(sourceFile)
  bundler.on "update", rebundle
  rebundle()

gulp.task "default", [
  "browserify"
  "watch"
]