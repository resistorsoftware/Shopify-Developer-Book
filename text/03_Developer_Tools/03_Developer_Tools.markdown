## The Developers Environment ##

As a developer with some experience, I have coded for many processors in many languages. From Z-80 Assembly language on the TRS-80,  68000 C on an Amiga 500,  C++ on a Sun Workstation to PHP on a homebrew Pentium, the tools used have not varied too much. These days, coding web applications on a laptop in a cafe is not unusual, and having beautiful tools to do so is a most welcome change. Developers are finally able to choose from some very fine tools indeed, and that was almost unheard of 5 or more years ago.

### The Text Editor ###

Vim, Emacs, TextMate, UltraEdit, Sublime Text, Eclipse, Visual Studio, Notepad, ... I am in no position to shed any light on this as I cannot even touch type. I get by only in the sense that I type at about the same speed I think. Maybe I think slow and my typing matches? I am not sure. I have never been tested. I am amazed when I see people writing code as they stare out the window at the kerfuffle happening out there at the coffee shop. Wish I could do that. As a manager I would use that as a test. If you want a job coding for me, and you cannot type, you cannot be a real coder. Simple. Although, that puts me on the breadline. 

My text editor has to have nice colors, easy on the eyes like Solarized. Has to syntax highlight Liquid, Haml and Sass, autosave all my code, and be a pleasure to search with. Sublime Text 2 fits that bill. I have no use for editors that have ftp or SVN built-in like that is something special.

### The Web Browser ###

Obviously every developer needs a good web browser to work from, one that provides decent tools for examining the results of Shopify theme tweaks or interactions with web applications. All the major browsers these days are suitable however each brings certain quirks to the table. My favorite is currently Chrome.

### Versioning your work ###

Shopify will version templates as you change them. However, this versioning is not terribly useful to a team and certainly is not something you want to rely on for your only backup. I suggest learning a version control system like git. A basic skill that will payoff in spades if you've never experienced it. You can version everything you work on. Every line of code, every proposal, even your binary work like images and assets that you might not ordinarily think of as something you version. 

### Dropbox ###

Dropbox is great way to cheaply share files and serves well for a workflow between small teams and clients. You can toss files into Dropbox and speed communications along and it beats managing large attachments in email. It has reasonable security most of the time too. 

### Skitch ###
 
Often I will take a screenshot and mark it up with Skitch and then share the resulting image with a client. It is fun to log in to your online accounting package, dig out the invoice you sent to the client 2 months ago, Skitch the timestamped entry showing they logged in and acknowledged the invoice, and fire that off to them. The mumbled excuses and apologies you get to hear about not seeing your invoice when they clearly did but conveniently forgot is a perk of the self-employed. 

### Instant Messaging ###
 
You have to use Skype, Adium, Pidgin, iChat or some other service to work with clients. Email does not cut it when you want to really rip through a work session with a client and bounce thoughts and ideas.  Screen sharing is one of the quickest ways to teach a client about what your App does, what the shiny buttons they can press do, and the luxury you've provided them. Writing a manual is fine too, but that takes many hours and in the end, the second you finish that manual it is full of errors or at least erroneous screen shots, descriptions and information as web apps can evolve in near real time, even after they have been "delivered". I often just re-factor my code just because I feel like it (and certainly not because v0.9 is embarrassing, although it might be).

### Terminal Mode or Command-Line Thinking ###
To make working on Shopify themes easier, Shopify has a command-line utility available that can be installed on any computer that has the Ruby programming language on it. The utility provides a few basic commands but the gist of it is that you can easily download a whole shop so that it resides on your computer's filesystem for editing. Once you do that, you can immediately check the entire codebase into a version control system. I like to use git for this task. You can choose to use any version control system you like. The next step is to tell the computer to watch for any changes in the theme files. If a change is detected like adding a Collection title to a template or a loop is adddedto render some navigation links in a menu, you want those changes automatically sent to the shop. That way, you can simply refresh your browser and see the changes you just made live. Even better, there is a development tool called Live Reload that will auto-refresh your browser whenever changes are detected to the code that is currently being rendered in the browser, meaning you can edit your Shopify theme or App, and simply switch focus to your browser to see the results without doing much more than a single keystroke combination.

### Localhost Development on a Laptop, Desktop or Other Devices ###

With text editing, version control, and watching for code changes in place, a developer is almost ready to tackle any kind of project. To develop an application that can be hooked up to a Shopify shop it will be imperative to be able to develop the application on your local machine. In the primitive days of web application development we had to ensure that we had a web server like Apache installed on our machines, in addition to scripting languages like Ruby, Python and PHP. That is an extra level of hassle we can do without these days. Conveniently the Ruby language comes with several extremely simple but fast web servers that make local development a breeze. For example the thin webserver by Marc-Andre Courneyer. Other options exist like Pow from 37Signals, WebBrick, Mongreal, Nginx, etc.  You have to find one you're comfortable with, and stick with it so as to be able to quickly whip up an App to test a concept out or to just be portable and not tied to a single server on the Internet. Being able to develop when offline is crucial. 

### Pre-Compiled CSS ###

A final tool for the Shopify developer that I think deserves more attention is the use of compiled CSS through the use of Less or Sass. These compilers allow a developer or designer to setup variables, establish styles to be mixed in with other styles, to extend existing styles and to ensure big and complex style sheets are managed with smaller, moduler files. Less can be compiled using Javascript, and Sass is compiled with Ruby. The advantages are somewhat spectacular in my opinion. You can build a complex Shopify theme's CSS using these tools and gain a lot of very interesting control. For example, to allow a client to change a color of a heading element, or the behaviour of a list, the same variables that you would use in Less or Sass can be programmed in Liquid. This means that a small Less or Sass effort can expand to a much larger more complex CSS file, that in turn becomes part of a Shop, but can be easily customized.
     