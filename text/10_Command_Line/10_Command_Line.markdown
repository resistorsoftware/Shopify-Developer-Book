## Command Line Shopify ##

Development of apps requires the ability to fire off requests to a shop and process the responses. [WebHooks](http://wiki.shopify.com/WebHook) are a source of incoming data from a shop, but there are many interesting options available to access the API at the command line. 

Firing off a request for a resource to a shop, uses JSON or XML and it occurs with a standard HTTP verb like GET. To send a GET request to a shop with authentication, is an involved process using the command line. A `curl` command to send off a request to a shop for a product or collection resource is somewhat complex. Who memorizes `curl` commands? It is tedious. There are better ways to do this. 

Shopify has a super application which they bundle with their Ruby gem, for the Shopify API. Before Rails merged with Merb, the Merbists advanced the concept of command line interface (CLI) development for Ruby, with the introduction of Thor. Thor is Ruby code that generates command-line interfaces and is a nice replacement for rake tasks. The new command is simple:

    $ shopify

Start a terminal session on your computer and you will be able to test this command out. You want to know the command-line and also want to have the Ruby scripting language and Shopify API gem installed.

<div class="figure">
  <img src="../images/CLI2.png" alt="Available Options for the shopify Command Line Interface" />
</div>

### The Shopify Command Line Console

There are just a few options listed. In order to really cook up some interesting examples, use the configure option that comes with the command. The arguments required to configure a Shopify session are the shop's API key and a password. To get those values, use the shop itself. For some developers, this will mean using their development shop. For others, their clients have provided access to their shop. So, a private app can be created. Or they have created the Private app for the developer and have passed on the credentials. The following screen shots show the exact sequence.

<div class="figure">
  <img src="../images/Manage%20Apps2.png" alt="Menu Options to Setup Shop Access for the Command Line" />
</div>

<div class="figure">
  <img src="../images/Private%20Application2.png" alt="Setting Up Access for a Private Application" />
</div>

<div class="figure">
  <img src="../images/Private%20App.png" alt="Final Step Reveals the Needed Access Credentials" />
</div>

When examining the credentials provided for a Private app tool, use the API key and password along with the shop name. Once the configuration is completed, accessing the shop using a command-line is easy. 

The following figure is a command-line session for a development shop that shows a query for the shop's count of products, orders and the details of a single order.

<div class="figure">
  <img src="../images/shopify_console.png" alt="Output of Calling a Shop Using the API" />
</div>

Quickly testing out potential code snippets without incurring a lot of overhead, is a huge benefit. API code can be tested with the fewest possible keystrokes and minimum effort with this handy command-line. It is possible to access metafield resources by providing an ID for the resource. The syntax of a call with Active Resource can be a challenge to keep in your head. With the command-line, it's possible to try out command syntax to see what the exact response will be. With the command-line, it is easier to try a few different call patterns before stumbling upon the desired one.

You can add connections to as many shops as needed and you can list them all. When working on a client shop, one of the first things to do is to use the shop admin interface and the app tab to create a private tool. The command-line is super useful to quickly test out any custom queries that are build into an app for the merchant. 

### The Shopify Theme Command Line Console

A second useful command line tool that Shopify provides is not in the `shopify_api` gem but a separate gem called `shopify_theme`. With this gem installed on a system, you can use the command `theme` to develop the shop theme. `theme` offers a simple workflow. The first thing to do with a shop development project is to create a directory to hold all the files that make up the merchant’s theme.

@@@ html
  $ mkdir fizz-buzz.com
  $ cd fizz-buzz.com
  $ theme configuration
@@@

<div class="figure">
  <img src="../images/theme%20console2.png" alt="Output of the Theme Command Line Console" />
</div>
    
The listing of available options and arguments to the `theme` commmand is slightly different from the `shopify` command. It does, however, use the same API key and password to access shop resources. The configuration is saved as a file `config.yml`. The first useful step, once configured, is to download the complete theme. 

    $ theme download
   
Once the assets are downloaded, set up the files under version control. Make a local repository with git and store the client's code under version control for safety. Advanced developers might even add a git remote pointing at github, so that all the work is safely stored in a private repository there too. 

@@@ html
    $ git init
    $ git add .
    $ git commit -m 'initial commit of Shopify code for client XYZ'
@@@

With the code in git, it is a great time to start working on the theme. Use the *theme watch* command to _watch_ the directory for any changes. As soon as a change is registered to a file, the theme watcher will transmit the changed file to the client site. Any changes can be stored in git. This ensures a smooth and hassle free development experience.

@@@ html
    $ git commit -am 'Fixed that pesky jQuery error the client had from \
     blindly copying and pasting some bad code off the Internet'
@@@

This is a very productive and safe workflow. Because the code is under version control, it is easy to edit theme code using your favourite tools. In the future, if the client wants more work done, you just use the `theme download` command to grab new files or changes, even if they are initiated by the merchant or others. Git will keep track of all changes. You have a fighting chance when you are not the only person touching or editing a merchant site. Squashing some other designer's work or other person's files is rarely an acceptable practice!