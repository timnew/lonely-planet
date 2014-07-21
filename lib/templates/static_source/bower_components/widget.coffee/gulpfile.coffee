require('coffee-script/register')
gulp = require 'gulp'
coffee = require 'gulp-coffee'
rimraf = require('rimraf')

paths = 
  coffee: ['./src/*.coffee']
  dist: './dist'

gulp.task 'clean', (done) ->
  rimraf paths.dist, done

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe gulp.dest paths.dist

gulp.task 'build', ['clean', 'coffee']
gulp.task 'default', ['build']

gulp.task 'watch', ['build'], ->
  gulp.watch paths.coffee, ['coffee']
