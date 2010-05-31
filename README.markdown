Pillow
============

The aim of this plugin is to offer a simple interface helpers for your layouts to set page titles and meta tags for your pages based on your current routes. 

This has not been tested in any other application other than mine and only with named routes, not with resources / nested_resources and their nested_routes.

Example
=======

Like this:

  root_pillow.title = 'Welcome to my homepage"
  root_pillow.metas[:keywords] = "Web Developer, Rails Developer, Plugin author..."

This is a work in progress but this is what the plugin does(partally).

In your layouts you will have a helper method. So far called pillow_helper.

  <html>
    <head>
      <%= pillow_helper %>
    </head>
    <body>
    ...
    </body>
  <head>

What this will do is try to match the current controller & action and find the appropriate helper and replace with the title you set and your metas if any. The example above would print for the root_url:

  <title>Welcome to my homepage</title>
  <meta content="Web Developer, Rails Developer, Plugin author..." name="keywords" />

TODO
=======

* A config/pillow.rb file so you can set the titles and meta tags there.
* Currently to use this plugin you need to run Pillow.enable in your app code, because the plugins are loaded before your app's routes are set, so the plugin can't find any route and therefore it can't create the helpers.

Copyright (c) 2010 Daniel Roux, released under the MIT license
