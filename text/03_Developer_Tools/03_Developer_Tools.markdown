## Shopify Developer Tools ##

As an engineer and software developer with some experience, over the years I have coded for many processors in many languages. From Z-80 Assembly language on the TRS-80's Zilog Z-80 8-bit CPU, through 6502, 6800 and 68000 chips, to Amiga 500, Sun Workstation C++ and then to PHP, Ruby and Javascript on homebrew Pentiums, the code editing tools used day to day have not varied much. Coding complex web applications on a laptop in a coffee shop is normal. For developers that want to create an App or build out a nice theme for a merchant all you need is an inexpensive laptop with Internet connectivity and the desire to learn.

### The Text Editor ###

Vim, Emacs, TextMate, UltraEdit, Sublime Text 2, Coda, Eclipse, Visual Studio, Notepad and the list goes on. Choosing a text editor is a very personal choice. I cannot touch type so I can offer no wisdom of choice. I get by with my horrid typing skills in the sense that I type at about the same speed as I think of code constructs. As long as my typing matches that speed I am happy. It is amazing to me when I see people writing code as they stare out the window at the coffee shop. If I was hiring a programmer I would use a typing skills test in the interview. Unsure of where that escape is? Are you sure you're a programmer? Back to the text editor itself. A text editor has to *syntax highlight* Ruby, Javascript, Liquid, Haml and Sass and other languages. It has to *autosave* all edits whenever typing stops and focus switchs to another task. 

### The Web Browser ###

Obviously every developer needs a good web browser to work with, one that provides decent tools for examining the results of Shopify theme tweaks or interactions with web applications. All the major browsers these days are suitable however each brings certain quirks to the table. Currently Chrome, Safari and Firefox offer decent developer tools. IE remains a poor choice since there developer tools for IE remain second rate at best.

### Versioning Your Work ###

Shopify will version templates as you change them. This built-in versioning system is not terribly useful for a team and certainly is not something you want to rely on for your only theme backup mechanism. Learning a distributed version control system (DVCS) like *git* is highly recommended. The *git* versioning system is a basic skill every developer should have that will payoff in spades. With git you can version *everything you work on*. Every line of code, every proposal, even binary work like images and assets that you might not ordinarily think of as something that should be under version control. Almost all the best open source projects are available using git and there is a serious community of developers all working and sharing code with git. [Github](http://github.com) offers free accounts and comes highly recommended as one of the best places to host your code base.

### Dropbox ###

Dropbox is great way to cheaply share files and serves well for a workflow between small teams and clients. You can toss files into Dropbox and speed communications along and it beats managing large attachments in email. It has reasonable security most of the time too. More and more applications are being released with Dropbox connectivity so it makes sense to adopt this into any workflow that needs it.

### Skitch ###
 
Screenshots remain a great way to start conversations about design and functionality. Skitch makes it easy to add notations to screenshots and then share the resulting image with a client. It can also be fun to Skitch invoices you sent to the client 2 months ago with the timestamped entry showing them logging in and seeing the invoice. Fire that image off to them and enjoy the mumbled excuses and apologies from their embarassment. Remarkably some clients are oblivious to their obligations and these are the ones to watch out for. Best to keep notes, printed and dates copies of agreements and to watch out for constantly changing requests. Some clients will accept an estimate for work, and once delivered they will suddenly change their requirements and expect the developer to go along with those changes. 

### Instant Messaging ###
 
Using Skype, Adium, Pidgin, iChat or other messaging service can really make it easier to work with clients. Email does not cut it when you want to really rip through a work session with a client and bounce thoughts and ideas of off them. Screen sharing is one of the quickest ways to teach a client about what your App does, what the shiny buttons they can press do, and to showoff the overlooked luxuries you've provided them. Writing a user manual for an App is fine too but that takes many hours and in the end the second you finish that manual it is likely outdated with defunct screen shots, descriptions and information as web apps can evolve in near real-time, even after they have been "delivered". Re-factoring code is a constant process and that makes documentation development tough. 

### Terminal Mode or Command-Line Thinking ###

Shopify makes a command-line (CLI) utility available that can be installed on any computer with the Ruby scripting language installed on it. The utility provides commands that allow a developer or designer to download a shop's theme for editing. Once downloaded the entire theme codebase can be checked into a version control system like git. There is also a command that tells the computer to watch for any changes in the theme files. If a change is detected in any files, including adding new ones those changes are automatically sent to the shop. You can simply refresh your browser and see the changes you just made. Even better there is a development tool called Live Reload that will auto-refresh your browser whenever changes are detected to the code that is currently being rendered in the browser meaning you can edit a theme or App, and then switch focus to your browser to see the results. As a developer learning to use the command line with skill and knowing how the operating system utilities work help is essential.

### Localhost Development on a Laptop, Desktop or Other Devices ###

With text editing, version control, and a web browser, a developer is ready to tackle almost any kind of Shopify project. To develop an application that can be hooked up to a merchant's shop it is imperative to be able to develop the application on your local machine. Testing a script out on a new concept or idea or running an entire App should not be tied to a server on the Internet. Being able to develop localhost when offline is crucial. Most common scripting languages used to develop web applications like Ruby and Python have nifty web servers for use on a local machine. Other languages get by with programs like Apache and Nginx. If you lose connectivity with the Internet at least you can keep developing and testing an App with this technique.  

### Pre-Compiled CSS ###

A final tool for the Shopify developer that deserves more attention is the use of compiled CSS through the use of Less or Sass. Less can be compiled with Javascript and Sass is compiled with Ruby. The advantages are somewhat spectacular. A developer can build a complex theme using these tools and gain a lot of very important flexibility. Changing one value in Sass or Less and the change propagates throughout the CSS easily. Developing stylesheets by hand is clearly the least efficient methodology especially when a developer does have a good understanding of how CSS works.
     