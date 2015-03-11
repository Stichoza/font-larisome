autoprefixer = require 'gulp-autoprefixer'
gulp         = require 'gulp'
gutil        = require 'gulp-util'
ignore       = require 'gulp-ignore'
minifycss    = require 'gulp-minify-css'
notify       = require 'gulp-notify'
plumber      = require 'gulp-plumber'
rename       = require 'gulp-rename'
stylus       = require 'gulp-stylus'

gulp.task 'styles', ->
  gulp.src 'src/stylus/**/*.styl'
    .pipe plumber
      errorHandler: notify.onError 'Error: <%= error.message %>'
    .pipe ignore.exclude '**/_*.styl'
    .on 'error', gutil.log
    .pipe stylus()
    .pipe autoprefixer 'last 5 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'
    .pipe rename
      suffix: '.min'
    .pipe minifycss
      processImport: yes
    .pipe gulp.dest 'css'

gulp.task 'watch', ->
  gulp.watch 'src/stylus/**/*', ['styles']
  return

gulp.task 'build', ['styles'], ->

gulp.task 'default', ['watch', 'build'], ->