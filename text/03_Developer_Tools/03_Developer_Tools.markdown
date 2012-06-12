## Shopify Developer Tools ##

As an engineer and software developer with some experience, over the years I have coded for many processors in many languages. From Z-80 Assembly language on the TRS-80's Zilog Z-80 8-bit CPU, through 6502, 6800 and 68000 chips, to Amiga 500, Sun Workstation C++ and then to PHP, Ruby and Javascript on homebrew Pentiums. The day-to-day code editing tools have not varied much. Coding complex web applications on a laptop in a coffee shop is also normal. For developers that want to create an app or build out a nice theme for a merchant, all you need is a laptop with Internet connectivity and a desire to learn.

### The Text Editor ###

Vim, Emacs, TextMate, UltraEdit, Sublime Text 2, Coda, Eclipse, Visual Studio, Notepad and the list goes on. Choosing a text editor is a very personal choice. I cannot touch type so in this regard, I can offer no wisdom. I get by with my horrid typing skills, in the sense that I type at about the same speed that I can think of code constructs. As long as my typing matches that speed, I am happy. It is amazing to me when I see people who write code as they stare out of a coffee shop window. If I was hiring a programmer, I would use a typing skills test in the interview. Unsure of where that Esc key is? Are you sure you're a programmer? 

Back to the text editor itself, a text editor has to *syntax highlight* Ruby, Javascript, Liquid, Haml and Sass, and other languages. It also has to *autosave* any edits whenever typing stops or focus switches to another task. 

### The Web Browser ###

Obviously, every developer needs a good web browser to work with. A good web browser provides decent tools for examining the results of any Shopify theme tweaks or web application interactions. Today, all the major browsers are suitable. However, each browser brings certain quirks to the table. Currently, Chrome, Safari and Firefox offer decent developer tools. While Internet Explorer remains a poor choice because their developer tools are second rate, at best.

### Versioning Your Work ###

Shopify will version templates as you change them. This built-in versioning system is not terribly useful for a team and is not something you want to rely on as your only mechanism to backup your theme. Learning a Distributed Version Control System (DVCS) like *git* is highly recommended. The git versioning system is a basic skill every developer should have. It will also payoff in spades. With git, you can version *everything you work on* - every line of code, every proposal, even binary work like images, and even assets that you might not ordinarily think of as something that should be under version control. Almost all the best open source projects are available using git. There is also a serious community of developers all working and sharing code with git. [Github](http://github.com) offers free accounts and comes highly recommended as one of the best places to host your codebase.

### Dropbox ###

Dropbox is great way to cheaply share files and serves well for a workflow between small teams and clients. You can toss files into Dropbox to speed communications along. It also beats managing large attachments in email and has reasonable security, most of the time. More and more applications are being released with Dropbox connectivity, so it makes sense to adopt this into any workflow that needs it.

### Skitch ###
 
Screenshots remain a great way to start conversations about design and functionality. Skitch makes it easy to add notations to screenshots and then share the resulting image with a client. It can also be useful to Skitch 2 month old client invoices, with the time stamp showing them logging in and viewing the invoice. Fire that image off to them and enjoy the mumbled excuses and apologies from their embarrassment. Remarkably, some clients are oblivious to their obligations and these are the ones to watch out for. It's best to keep notes, print and date copies of agreements. Also, watch out for constantly changing requests. Some clients will accept an estimate for work but once the work is delivered, they will suddenly change their requirements and expect the developer to go along with those changes.

### Instant Messaging ###
 
Using Skype, Adium, Pidgin, iChat or another messaging service can really make it easier to work with clients. Email does not cut it when you want to really rip through a work session with a client and bounce ideas off of them. Screen sharing is one of the quickest ways to teach a client about what your app does, what the shiny buttons do and to show off the overlooked luxuries you've provided them. Writing a user manual for an app is fine too but that takes many hours. Also, the second you finish writing, the manual is likely outdated with defunct screen shots, descriptions and information because web apps can evolve in near real-time, even after they have been "delivered". Re-factoring code is a constant process and that makes documentation development tough.

### Terminal Mode or Command-Line Thinking ###

Shopify makes a Command-Line (CLI) utility available that can be installed on any computer with Ruby scripting language on it. The utility provides commands that allow a developer or designer to download a shop's theme for editing. Once downloaded, the entire theme's codebase can be checked into a version control system like git. There is also a command that tells the computer to watch for any changes in the theme files. If a change is detected in any file or if new files are added, those changes are automatically updated in Shopify. This lets you refresh your browser and see the changes you've just made. Even better, there is a development tool called Live Reload that will auto-refresh your browser whenever changes are detected to the code. This means you can edit a theme or app and then switch your focus to your browser to see the results.

### Localhost Development on a Laptop, Desktop or Other Devices ###

With text editing, version control and a web browser, a developer is ready to tackle almost any kind of Shopify project. To develop an application that can be hooked up to a merchant's shop, it is imperative to be able to develop the application on your local machine. Testing a script out on a new concept or running an entire app, should not be tied to a server on the Internet. It is crucial to be able to develop localhost when offline. Most scripting languages that are used to develop web applications like Ruby and Python, have nifty web servers for use on a local machine. Other languages get by with programs like Apache and Nginx. With this technique, if you lose Internet connectivity at least you can keep developing and testing an app.

### Pre-Compiled CSS ###

A final tool for the Shopify developer (and one that deserves more attention) is the use of compiled CSS through the use of Less or Sass. Developing style sheets by hand is clearly the least efficient method, especially when a developer does not have a good understanding of how CSS works. Less can be compiled with Javascript. Sass is compiled with Ruby. The advantages are somewhat spectacular. A developer can build a complex theme using these tools and gain a lot of very important flexibility. By changing one value in Sass or Less, the change propagates throughout the CSS. 
     