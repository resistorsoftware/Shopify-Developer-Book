# Shopify Developer HandBook

Markdown code was turned into epub, html and PDF version using Kitabu. Clone the fork from Jesse Storimer for starters. It has some nice tweaks not present in the master kitabu repository. [kitabu](https://github.com/jstorimer/kitabu)

After cloning the gem can be build with the command:  *gem build GEMSPEC_FILE* and once built, the gem can be installed for use.

The free version of Prince needs to be present to use Kitabu. A final PDF without branding can be had with an online service, but for testing and development the free version is great. [Prince](http://www.princexml.com/download/)

Since the project exists, the command line directive *kitabu export* will build the project and populate the output directory with the PDF, epub and html version. The markdown files reference artwork in the _images_ directory.

I setup the look of the final result using Sass file _templates/html/sass/screen.sass_ that will result in a CSS stylesheet called screen.css being built and used. This screen.css file is referenced in the HTML layout file _templates/html/layout.erb_ that ultimately serves as the reference by which Prince can turn the HTML into nice PDF. Tweaking that sass file is the key to tweaking the look of the final output. 
 