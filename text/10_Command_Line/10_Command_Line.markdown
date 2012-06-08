## Command Line Shopify ##

Development of Apps requires being able to fire off requests to a shop and to be able to process the responses. WebHooks are a source of incoming data from a shop but there are many interesting possibilities available using a console terminal to access the API at the command line. 

Firing off a request for a resource to a shop uses JSON or XML and it occurs with a standard HTTP verb like GET. To send a GET request to a shop with authentication is an involved process using the command line. A curl command to send off a request to a shop for a product or collection resource is somewhat complex. Who memorizes curl commands? It is tedious. There are better ways to do this. 

Shopify has a super application they bundle with their Ruby gem for the Shopify API. Before Rails merged with Merb, the Merbists advanced the concept of command line interface (CLI) development for Ruby with the introduction of Thor. Thor is Ruby code that generates command-line interfaces and is a nice replacement for rake tasks. The new command is simple - *shopify*.

Start a terminal session on your computer and you will be able to test this command out. You do know the console and you do want to have the Ruby scripting language and the Shopify API gem installed.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/CLI2.png" alt="Available Options for the shopify Command Line Interface" />
</div>

### The Shopify Command Line Console

There are just a few options listed and in order to really cook up some interesting examples, use the configure option that comes with the command. The arguments required to configure a Shopify session are the shop's API key and a password. To get those values, use the shop itself. For some developers, this will mean using their development shop. For others, their clients have provided access to their shop so a private App can be created. Or they created the Private App for the developer and pass on the credentials. The following screen shots show the exact sequence.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Manage%20Apps2.png" alt="Menu Options to Setup Shop Access for the Command Line" />
</div>


<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Private%20Application2.png" alt="Setting Up Access for a Private Application" />
</div>


<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Private%20App.png" alt="Final Step Reveals the Needed Access Credentials" />
</div>


When examining the credentials provided for a Private App Tool, use the API key and password along with the shop name. Once the configuration is completed access the shop using a console is easy. 

The following figure is a console session for a development shop showing a query for the shop's count of products, orders, and the details of a single order.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/shopify_console.png" alt="Output of Calling a Shop Using the API" />
</div>


Quickly testing out potential code snippets, without incurring a lot of overhead, is a huge benefit. API code can be tested with the fewest possible keystrokes and minimum effort with this handy console. It is possible to access metafield resources by providing an ID for the resource. The syntax of a call with Active Resource can be a challenge to keep in your head. With the console, it's possible to try command syntax out to see what the exact response is. With the console, it is easier to try a few different call patterns until stumbling upon the desired one.

You can add connections to as many shops as needed and you can list them all. When working on a client shop, one of the first things to do is to use the shop admin interface and the App tab to create a private tool. The console is super useful to quickly test out any custom queries to build into an App for the merchant. 

### The Shopify Theme Command Line Console

A second useful command line tool that Shopify provides is not in the shopify\_api gem but is a separate gem called shopify\_theme. With this gem installed on a system you can use the command **theme** to develop the shop theme. Theme offers a simple workflow. The first thing to do with a shop development project is to create a directory to hold all the files that make up the merchant's theme.

    $ mkdir fizz-buzz.com
    $ cd fizz-buzz.com
    $ theme configuration


<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/theme%20console2.png" alt="Output of the Theme Command Line Console" />
</div>
    
The listing of available options and arguments to the *theme* commmand is slightly different from the *shopify* command. It does use the same API key and password to access shop resources. The configuration is saved as a file config.yml. The first useful step, once configured, is to download the complete theme. 

    $ theme download
   
Once the assets are downloaded, set up the files under version control. Make a local repository with git and store the client's code under version control for safety. Advanced developers might even add a git remote pointing at github so that all work is safely stored in a private repository there too. 

    $ git init
    $ git add .
    $ git commit -m 'initial commit of Shopify code for client XYZ'
    
With the code in git, it is a great time to start working on the theme. Use the *theme watch* command to _watch_ the directory for any changes. As soon as a change is registered to a file, the theme watcher will transmit the changed file to the client site. Any changes can be stored in git. This ensures a smooth and hassle free development experience.

    $ git commit -am 'Fixed that pesky jQuery error the client had from blindly copy and pasting some bad code off the Internet'
    
This is a very productive and safe workflow. The code is under version control and it is easy to edit theme code using your favourite tools. In the future, if the client wants more work done you just use the _theme download_ command to grab new files or changes to files initiated by the merchant or others. Git will keep track of all changes. You have a fighting chance when you are not the only person touching or editing a merchant site. Squashing some other designer's work or other person's files is rarely an acceptable practice!
 