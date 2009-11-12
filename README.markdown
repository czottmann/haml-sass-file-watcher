### WHAT IT DOES

Keeps an eye on a specified folder, waiting for HAML/SASS file changes. When a
file was changed, it's re-generated in `#{watch_folder}/output/` or
`#{watch_folder}/css/`.


### USAGE

`ruby watcher.rb watch_folder`.


### EXAMPLE

`ruby watcher.rb /Users/Lebowski/Code/my_project` will watch both both
`/Users/Lebowski/Code/my_project/haml/` and
`/Users/Lebowski/Code/my_project/sass`. When a contained HAML or SASS file
is touched/saved, a new HTML or CSS file with the same basename is generated 
and saved in either `/Users/Lebowski/Code/my_project/output/` (HTML) or
`/Users/Lebowski/Code/my_project/css/`.


### LICENSE

This code is released under the [WTFPL](http://sam.zoy.org/wtfpl/COPYING).