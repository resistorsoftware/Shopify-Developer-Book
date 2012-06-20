## Shopify Inventory

When working out a development plan for a merchant's shop, the inventory setup should come first and the theme should come last. Unfortunately, many merchants jump into a theme only to realize that while it looked good in theory, the reality is much different with their actual inventory. To achieve success, a shop needs to present inventory in a way that complements a smooth shopping experience. It is not gimmicks that sell. Sometimes deeper thinking about a product, its variants, pricing, images and options, will dictate the best presentation and process. If the inventory is not organized correctly, a lot of effort will be wasted trying to fix up a theme. 

At a minimum, a product requires only a title. The title will then be turned into a unique *handle* that is a reference to the product in the shop. A quick example is a product with the title **Quick Brown Fox**.

Shopify will set a handle to this product as **quick-brown-fox** and the product will then be found online as the shop's URL appended with `/products/quick-brown-fox`. With no further action from a merchant, a new product has been created and added to inventory with a zero dollar price, infinite inventory for sale, no tags or images, no description nor other useful attributes. It exists for the purposes of showing up on the site and can be accessed with an API call using the handle or assigned ID. You can *always* get the ID of a product by looking at the URL in the shop admin, when editing it. An example is `/admin/products/90368349` where `90368349` is the unique ID for the product. As long as that product exists in the shop, that number will never change. The number is used during import and export operations in order to identify products that need to be updated. It is also handy to use that number when quickly checking out a product with the API. For example, to quickly see if a product has any metafields, a very quick but effective command-line effort would be:

<div class="figure">
  <img src="../images/api_call_615.png" alt="Example API Call" />
</div>


With just a couple of keystrokes, the product is shown. Also, it has no metafield resources attached to it. 

When setting up a product in inventory, the variant can be assigned a title as well as a price, SKU and inventory management policies. Shopify also provides three options that can be assigned to a variant. If a product has a colour, size and material, they are supported as variant options. These options can be anything, so there is a fair amount of flexibility in using them. A product with attributes like density, plasticity, taste, style or even chemical composition can be setup too. Assuming that all three options are used, Shopify allows a product to have up to 100 variants. This means a product with five colours, four sizes and three materials would require sixty variants (5 x 4 x 3 = 60). Each one counts as an SKU in Shopify for the selected pricing plan. It is not necessary to assign an SKU to each variant. You can also assign the same SKU to as many variants as you need. Shopify simply treats the SKU as an attribute with no special meaning. Using the Shopify AJAX API, it is very simple to use the handle of a product to get all of its attributes. If we open a store that has a version of the API code rendered as part of the theme, we can use the developer tools of our browser to inspect the details.

<div class="figure">
  <img src="../images/ajax_call_615.png" alt="Getting Product Info using AJAX" />
</div>

An examination of the object representing a Shopify product shows us the structure of the requested product that is responsible for the attributes generated for each variant. We can use this to completely customize the way Shopify renders products and variants. Many shops use the code that Shopify provides in order to render each option as a separate HTML select element, instead of one select element with each element separated with slashes. When a selection is made, a callback is triggered with the variant. That allows a shop to update things like pricing and availability. It is simple, reliable and it works. It can be relied on by developers to take front-end shop development to the next level beyond the basics. 

If there are images uploaded for a product, it is possible to detect images that might match the SKU assigned to the variant or variant title. It is easy to make up some rules dictating how these images are coded, so that code can be used in the callback logic. 

### Summary of Developing Code with Products ###

Knowing how Shopify inventory works, with respect to variants and options, is crucial to building shops with advanced capabilities. To take a shop to a level where customers can easily add the product or products of their choice to the cart and buy it without too much effort or guesswork is essential. The first thing to keep in mind is that the product has options. There can be three. They have simple names like Colour, Size or Title. The product object you get from Liquid allows an inspection of the options array to see which ones are present. Every product can have different options, so it makes sense to always have some code that checks the ones assigned to the product. 

@@@ javascript
  // save product into a Javascript variable we can inspect.
  var product = {{ product | json}};
  console.log("Product %o has Options %o", product, product.options);
@@@

When rendering with the Shopify _option\_selectors_ code, there is a callback function that receives the selected variant. Logging that to the console shows the option values of the selected variant. A variant will always provide three attributes: option1, option2 and option3. If the value of the first product option was set to colour, the value of variant attribute option1 might be "red". At the same time, there is a variant attribute called options. Options is an array that would have an entry where the first slot would be occupied by the value "red" as well. So there are two ways to determine a variant's current options. 

While the options are determined, the variant ID is also known. Therefore, it makes sense if a shop needs to present clickable images, buttons or swatches. All the elements are present to support code development for this. Hiding the usual dropdowns and rendering a clickable swatch that provides the variant options or even the ID can thus be used to ensure that the correct item ends up in the cart. At some point, it is likely to become a common option for shops to present clickable images or swatches.
