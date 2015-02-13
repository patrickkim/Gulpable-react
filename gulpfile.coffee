gulp         = require "gulp"
notify       = require "gulp-notify"
sourcemaps   = require "gulp-sourcemaps"
rename       = require "gulp-rename"
sass         = require "gulp-sass"
autoprefixer = require "gulp-autoprefixer"
minify_css   = require "gulp-minify-css"
browserify   = require "gulp-browserify"
uglify       = require "gulp-uglify"
concat       = require "gulp-concat"
image_min    = require "gulp-imagemin"
cache        = require "gulp-cache"
svg_min      = require "gulp-svgmin"
del          = require "del"
process_html = require "gulp-processhtml"
plumber      = require "gulp-plumber"

# Refresh everything
gulp.task "clean_styles", ->
  del("dev/assets/css")

gulp.task "clean_scripts", ->
  del("dev/assets/js")

#HTML
gulp.task "html", ->
  gulp.src "src/html/*.html"
    .pipe gulp.dest("dev")

# Styles
gulp.task "css",  ->
  gulp.src "src/stylesheets/development.scss"
    .pipe sourcemaps.init()
    .pipe plumber()
    .pipe sass()
    .pipe sourcemaps.write()
    .pipe autoprefixer("last 2 version", "ie 9")
    .pipe rename("main.css")
    .pipe gulp.dest("dev/assets/css")
    .pipe notify(message: "Styles task complete")

# Scripts
gulp.task "js", ->
  gulp.src "src/javascripts/index.coffee", { read: false }
    .pipe plumber()
    .pipe browserify(
      debug: true
      transform: ["coffee-reactify"]
      extensions: [".coffee", ".cjsx"]
      requires: ["lodash", "immutable", "alt", "react"])
    .pipe concat("bundle.js")
    .pipe gulp.dest("dev/assets/js")
    .pipe notify(message: "Scripts task complete")

# Images
gulp.task "images", ->
  gulp.src "src/images/**/*"
    .pipe cache( image_min(optimizationLevel: 3, progressive: true, interlaced: true) )
    .pipe gulp.dest("dev/assets/images")
    .pipe cache.clear()
    .pipe notify(message: "Images smushed!")

# Minify your SVG.
gulp.task "svg", ->
  gulp.src "src/vectors/*.svg"
    .pipe svg_min()
    .pipe gulp.dest "dev/assets/vectors"
    .pipe notify(message: "SVG smushed!")

gulp.task "build", ["clean_styles", "clean_scripts", "css", "js"]

# Build everything and smush it!
gulp.task "release", ["clean_build"], ->

  gulp.src "src/html/*.html"
    .pipe process_html()
    .pipe gulp.dest("release")
    .pipe notify(message: "HTML ready!")

  gulp.src "src/stylesheets/production.scss"
    .pipe sass()
    .pipe autoprefixer("last 2 version", "safari 5", "ie 8", "ie 9", "opera 12.1", "ios 6", "android 4")
    .pipe minify_css()
    .pipe rename("main.min.css")
    .pipe gulp.dest("release/assets")
    .pipe notify(message: "Styles build complete")

  gulp.src "src/javascripts/index.coffee", { read: false }
    .pipe browserify(
      debug: true
      transform: ["coffee-reactify"]
      extensions: [".coffee", ".cjsx"]
      requires: ["lodash", "immutable", "alt", "react"])
    .pipe concat("bundle.min.js")
    .pipe uglify()
    .pipe gulp.dest("release/assets")
    .pipe notify(message: "JS ready!")

  gulp.src "src/vectors/*.svg"
    .pipe svg_min()
    .pipe gulp.dest "release/assets"
    .pipe notify(message: "SVG ready!")

  gulp.src "src/images/**/*"
    .pipe cache( image_min(optimizationLevel: 3, progressive: true, interlaced: true) )
    .pipe gulp.dest("release/assets")
    .pipe cache.clear()
    .pipe notify(message: "Images ready!")

# Watch
gulp.task 'watch', ->
  gulp.watch 'src/stylesheets/**/*.scss', ["css"]
  gulp.watch 'src/javascripts/**/*', ["js"]
  gulp.watch 'src/html/**/*.html', ["html"]

gulp.task 'default', ['html', 'css', 'js', 'images', 'svg']
