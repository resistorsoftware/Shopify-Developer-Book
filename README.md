# Shopify Developer HandBook

Markdown code was turned into epub, html and PDF version using Kitabu. Clone the fork from Jesse Storimer for starters. It has some nice tweaks not present in the master kitabu repository. [kitabu](https://github.com/jstorimer/kitabu)

After cloning the gem can be build with the command:  *gem build GEMSPEC_FILE* and once built, the gem can be installed for use.

The free version of Prince needs to be present to use Kitabu. A final PDF without branding can be had with an online service, but for testing and development the free version is great. [Prince](http://www.princexml.com/download/)

Since the project exists, the command line kitabu export will suffice to populate the output directory with the PDF, epub and html version. The markdown files reference artwork in the _images_ directory.