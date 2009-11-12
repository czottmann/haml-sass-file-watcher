### What It Does

Keeps an eye on a specified folder, waiting for HAML/SASS file changes. When a
file was changed, it's re-generated in `#{watch_folder}/output/` or
`#{watch_folder}/css/`.


### Usage

    ruby watcher.rb watch_folder


### Example

Running `ruby watcher.rb /Users/Lebowski/Code/my_project` will watch both both
`/Users/Lebowski/Code/my_project/haml/` and
`/Users/Lebowski/Code/my_project/sass/`. When a contained HAML or SASS file
is touched/saved, a new HTML or CSS file with the same basename is generated 
and saved in either `/Users/Lebowski/Code/my_project/output/` (HTML) or
`/Users/Lebowski/Code/my_project/css/`.


### Fragments / Includes

Using the custom `%include` tag in HAML files you can include other HTML files.
Think "fragments".

Example:

    %h1 test omg
    %include{ :file => "my_fragment" }
    %h2 test lol

This will fetch the `#{watch_folder}/output/my_fragment.html` file and replace
the `%include` tag/placeholder with its contents.

This is a rather simple implementation. Again, it works for me, which all I
needed.


### License

This code is released under the [WTFPL](http://sam.zoy.org/wtfpl/COPYING).