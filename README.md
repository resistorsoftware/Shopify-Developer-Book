# Shopify Developer HandBook

Originally authored by Dave Lazar and edited by Stacey Hsu, Edward Ocampo-Gooding, and Blair Beckwith.

This book is here to give you the Shopify Platform Developer a leg up in your new (or old) adventure.

## Setup

These steps assume you have a working installation of Ruby, bundler, git, and a C/C++ compiler like gcc.

1. Install bundled dependencies:

    `$ bundle install`

2. Install the trial version of Prince, an HTML to PDF generator. Check the [Prince download page](http://www.princexml.com/download/) for the version for your operating system. Installation for OS X looks like this:

    `$ curl --remote-name http://www.princexml.com/download/prince-8.0-macosx.tar.gz`

    `$ tar zxvf prince-8.0-macosx.tar.gz`

    `$ prince-8.0-macosx/install.sh`

3. Clean up the install:

    `$ rm -rf prince-8.0-macosx prince-8.0-macosx.tar.gz`

## Building

Build the book by running:

    $ ./build

Results of the build are found in `output/`, like `output/Shopify-Developer-Book.pdf`

## Tweaking

You can change the overall look of the book by altering `templates/html/sass/screen.sass` and other files in `templates/html/sass/`, and rebuilding the book.

## Contributing

Send http://github.com/edward/Shopify-Developer-Book a pull request on GitHub.

## License

Shopify Developer HandBook by Shopify is licensed under a Creative Commons Attribution-NonCommercial 3.0 Unported License. Read more about the license at http://creativecommons.org/licenses/by-nc/3.0/