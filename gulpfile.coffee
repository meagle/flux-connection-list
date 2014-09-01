gulp = require("gulp")
browserify = require("gulp-browserify")
watchify = require("gulp-watchify")
source = require("vinyl-source-stream")
coffeeify = require "coffeeify"
reactify = require "reactify"
rename = require 'gulp-rename'
sourceFile = "./public/coffee/**/*.coffee"
destFolder = "./public/js/"
destFile = "bundle.js"

gulp.task "browserify", ->
  gulp.src(sourceFile, { read: false })
    .pipe(browserify({
      transform: ['coffeeify', 'reactify'],
      extensions: ['.coffee']
    }))
    .pipe(rename(destFile))
    .pipe gulp.dest(destFolder)

# gulp.task "watch", ->
#   rebundle = ->
#     bundler.bundle()
#     .pipe(source(destFile))
#     .pipe gulp.dest(destFolder)
    
#   bundler = watchify(sourceFile)
#   bundler.on "update", rebundle
#   rebundle()

gulp.task 'watch', ->
  gulp.watch sourceFile, ['browserify']

gulp.task "default", [
  "browserify"
  "watch"
]


