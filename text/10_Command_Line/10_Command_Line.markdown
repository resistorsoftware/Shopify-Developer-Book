## Command Line Shopify ##

Quick development of Apps requires being able to fire off requests to a shop and to be able to process the responses. While WebHooks are a source of incoming data from a Shop many interesting possibilities are available using a terminal to access the API at the command line. 

When firing off a request for a resource from a Shop using one of the formats of JSON or XML, we are using a standard HTTP verb like GET. To quickly send a GET request to a shop with authentication can be an involved setup process using the command line. For example, we could use the venerable curl command to send of a request for a Shop, Product or Collection resource. Doing so by hand can be tedious in my opinion. There are much more sophisticated ways to do this without having to run an App and inspect the responses and run debuggers. While I enjoy single-stepping through live code and inspecting the state of my objects that make up an App, I also appreciate being able to quickly test out a theory or check on code syntax without the burden of that overhead. 

Shopify has a super example of how to do just this and it is a small application they bundle with their Ruby gem. Some time ago, before Rails merged with Merb, the Merbists advanced the concept of command-line interface (CLI) development for Ruby with the introduction of Thor. Thor is Ruby code that lets you quickly write a command-line interface. The current Shopify API gem comes with one of these built-in.

 If you have installed the Shopify API gem and you start a terminal session on your computer you will be able to test this out fairly quickly. I use RVM to manage all my versions of Ruby, but there are alternatives including RBENV and the usual nothing special at all I use the default installed with my computer. I am making the bold assumption that most developers are using a computer with Ruby (or any dynamic scripting language for that matter, be it Perl, PHP, Python or others) and that a terminal session is part of their toolkit. 
 
When I use Ruby, and I check my installed gems using the gem list command, I see the shopify api gem in my list and I can test for the Shopify CLI by simply typing in the command **shopify**. 

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/CLI2.png" alt="Available Options for the shopify Command Line Interface" />
</div>

### The shopify Command Line Console

There are just a few options listed and in order to really cook up some interesting examples we will use the configure option that comes with the command. The options required to configure a shopify session are the Shops API key and a password. To get those values, we will use the Shop itself. For some developers this will mean using their development shop, and for others, their clients have provided access to their shop so a private App can be created, or they created the Private App for the developer and passed on the credentials. The following screen shots show the exact sequence.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Manage%20Apps2.png" alt="Menu Options to Setup Shop Access for the Command Line" />
</div>

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Private%20Application2.png" alt="Setting Up Access for a Private Application" />
</div>

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/Private%20App.png" alt="Final Step Reveals the Needed Access Credentials" />
</div>

When examining the  credentials provided for a Private App Tool, we use the API key and Password along with the shop's name. Once we have completed the configuration, we can access the shop using a console. 

As an example, here is a console session for a development shop, showing how easy it is to query for the shop's count of products, orders, and the details of a single order.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/shopify_console.png" alt="Output of Calling a Shop Using the API" />
</div>

Now we can test out potential code snippets quickly without incurring a lot of overhead. API code can be tested with the fewest possible keystrokes and minimum effort with this handy console. For example we know we can access metafields resources for a shop by providing an ID for the resource. What is the syntax of a call with Active Resource? It can be a challenge to keep perfect API syntax in your head, so we often just try things out to see if they work. With the console I can try a few different call patterns until I stumble on the correct one.

With the shopify utility we can add connections to as many Shops as we want and we can list them all. When working on a client shop one of the first things I do is use the shops admin interface and the App tab to create a private tool. With the resulting API key and password I can use the shopify console tool to quickly test out any custom queries I may want to build into an App for the client. 

### The Shopify Theme Command Line Console

The second useful command line tool that Shopify provides is not in the shopify_api gem but is a separate gem called shopify_theme. With this gem installed on your system you can use the command **theme** to work with shop code directly. Theme is another fine command line tool with a simple workflow. The first thing I do with a new client is create a directory to hold all the files that make up the client's theme.

    $ mkdir fizz-buzz.com
    $ cd fizz-buzz.com
    $ theme configuration


<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/theme%20console2.png" alt="Output of the Theme Command Line Console" />
</div>
    
You can see from the listing of available options the *theme* commmand is slightly different from the *shopify* command. Nonetheless it uses the exact same API key and password to access a shop's resources. Provide the credentials and the configuration is written out as a file and we can begin work. The first step is to download the client's theme into the working directory so that I can examine their Javascript, and Liquid assets like the templates. 
 
    $ theme download
   
Once the assets are downloaded I setup the files under version control. I make a local repository with git and store the client's code under version control for safety. You could even go so far as to setup a git remote pointing at github so that your work is safely stored in a private repository there too. 

    $ git init
    $ git add .
    $ git commit -m 'initial commit of Shopify code for client XYZ'
    
With the code in git it is a good time to start working. I use the *theme watch* command to watch the directory for any changes. As soon as a change is registered to a file, the theme watcher will transmit the changed file to the client site where the file was downloaded from. I can verify my edit worked (or not) using my web browser and viewing the shop. When I am happy a small change is a good change I commit the change to git and move on to the next task.

    $ git commit -am 'Fixed that pesky jQuery error the client had from blindly copy and pasting some bad code off the Internet'
    
 This is a very productive and safe workflow in my opinion. I have the code under version control and I can make my edits using my favorite code editing tools. If in the future the client wants more work done I can use the theme download tool to grab any new files or changes to files initiated by the client in the meantime. Git will tell me what changes if any are present and I can investigate those. Sometimes it is a simple task to fix something this way. At least you have a fighting chance when you are not the only person touching or editing a client site. Squashing some designers work or other persons files is rarely an acceptable practice!
 
    

