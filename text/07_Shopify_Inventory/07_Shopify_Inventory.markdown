## Shopify Inventory

When working out a development plan for a merchant's shop the inventory setup should come first and the theme should come last. Unfortunately many merchants jump into a theme only to realize later that while it looked good in theory, the reality is much different with their actual inventory. To achieve success a shop needs to present inventory in a way that complements a smooth shopping experience and that it is not gimmicks that sell. Sometimes deeper thinking about how a product and it's variants, pricing, images and options will dictate the best presentation and process. If the inventory is not organized correctly a lot of effort can be wasted trying to fix a theme up. 

A product requires at a minimum only a title. The title will then be turned into a unique *handle* that is a reference to the product in the shop. A quick example is a product with the title **Quick Brown Fox**. Shopify will set a handle to this product as **quick-brown-fox** and the product will then be found online as the shop's URL appended with _/products/quick-brown-fox_. With no further action from a merchant a new product has been created and added to inventory with a zero dollar price, infinite inventory for sale, no tags, images, description or other useful attributes. It exists for the purposes of showing up on the site and can be accessed with an API call using the handle or ID it was assigned. You can *always* get the ID of a product simply by looking at the URL in the shop admin for the product when editing it. An example would be /admin/products/90368349 where the _903368349_ is the unique ID for the product. As long as that product exists in the shop that number will never change. It is used during import and export operations to identify products that will need to be updated. It is also handy to use that number when quickly checking out a product with the API. For example perhaps we want to quickly see if a product has any metafields. A very quick but effective command-line effort would be:

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/api%20call2.png" alt="Example API Call" />
</div>

With just a couple of keystrokes we found a product and we are able to see that it has no metafield resources attached to it. 

When setting up a product in inventory we can edit the variant and provide a title for the variant as well as it's price, SKU and inventory management policy. Shopify also provides three options that can be assigned to a variant. If a product has a colour, size and material they can be accommodated as options. These options could be anything so there is a fair amount of flexibility in using them. A product with attributes like density, plasticity, taste, style, or even chemical composition could be setup. Assuming all three options are used Shopify allows a product up to 100 variants. This means a product with five colours, four sizes and three materials would require 5 times 4 times 3 or 60 variants. Each one counts as an SKU in Shopify for the pricing plan selected. It is not necessary to assign an SKU to each variant, and you can assign the same SKU to as many variants as needed. Shopify simply treats the SKU as an attribute with no special meaning. Using the Shopify Ajax API it is very simple to use the handle of a product to get all of it's attributes. If we open up a store that has a version of the API code rendered as part of the theme, we can use the developer tools of our browser to inspect the details.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/ajax%20product2.png" alt="Getting Product Info using Ajax" />
</div>

An examination of the object representing a Shopify product shows us the structure of a product's options and how they are responsible for attributes generated for each variant. We can use this to completely customize the way Shopify renders products and variants. Many shops use the code Shopify provides to render each option as a separate HTML select element instead of one select element with each element separated with slashes. When a selection is made, a callback is triggered with the variant and that allows a shop to update things like pricing and availability. It is simple, reliable and it works. It can be relied on by developers to take front-end shop development to the next level beyond those basics. 

If there are images uploaded for a product it is possible to detect images that might match the SKU assigned to the variant or perhaps the variant title. It is easy to make up some rules dictating how images that are uploaded for a product are coded so that code can be used in the callback logic. 

### Summary of Developing Code with Products ###

Knowing how Shopify inventory works with respect to variants and options is crucial to building out shops with advanced capabilities. To take a shop to a level where customers can easily add the product or products of their choice to the cart and buy it without guesswork or too much effort is essential. The first thing to keep in mind is that the product has options. There can be three. The have simple names like Colour, Size or Title. The product object you get from Liquid allows an inspection of the options array to see which ones are present. Every product can have different options so it makes sense to always have some code that checks the ones assigned to the product. 

@@@ javascript
  // save product into a Javascript variable we can inspect.
  var product = {{ product | json}};
  console.log("Product %o has Options %o", product, product.options);
@@@

