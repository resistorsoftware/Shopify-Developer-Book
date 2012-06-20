## Common Questions ##

There are plenty of reasons to choose a *hosted* platform like Shopify. One reason is that the responsibility for ensuring that your shop's site is reachable by the public is purely Shopify's. By offering a platform that provides most of the basic features needed to run an ecommerce website, Shopify has created a thriving community of shops that sell everything from soup to nuts. There is decent community support for most merchants that are new to the platform; it can be comforting to know that when an issue arises while configuring a shop, there are other people who have faced the same issue and have likely resolved it. 

### How to Capture Extra Information ###

One of the earliest and most common questions is how to go about capturing custom information for products in an order. There are thousands of shops that need to collect custom information such as product customization or other special order details. The presentation of a form to collect this information is a source of endless discussion by merchants. 

With the introduction of *cart attributes*, it became possible (but not necessarily simple) to pass extra data through checkout with an order. The cart attributes are a simple key:value pair where a key is used to refer to some value. An order can have as many of these cart attributes as they need to fully define product customization. A typical key might be the identification number of a product or variant. The value that can be stored with the key is usually a string of text. The following code presents three examples of setting simple key and its value.

@@@ javascript attributes.js:1,3 @@@

Using Javascript, it is possible to experiment by setting a cart attribute and then checking whether it was set correctly. Javascript represents data and objects in a format called JSON. One excellent fact about this is that JSON can be stored as a text string and that means merchants and developers can create complex data structures and save them as cart attributes with any order! The third example shows this off. The cart attribute for ID 44556677 has been assigned a string of JSON. The value could be read as "There are TWO 44556677 variants in the cart. One is named *qbf* and the other *jtld*". When rendering the cart to customers, it's possible to show these values in the appropriate line item along with the variants. The checked out order will display the same keys and values.
   
@@@ javascript attributes.js:5,5 @@@

Not only is the above script a little confusing, but some merchants may balk at having the collected custom information look like that. It is possible to deal with this by using more sophisticated code. Instead of directly storing the customization data in cart attributes, it can be stored in a cookie or the web browser's built-in localStorage. During the creation and subsequent editing of customized information, it is handled as JSON. Before submitting the order to checkout, the code can translate the JSON into plain English. That would then be set as the value in the cart attributes. As an example, if a variant represented a type of farm animal for a selling price of $24.00, the attribute could be represented as:

@@@ javascript attributes.js:7,7 @@@
      
This is more readable than the previous example and can be easily interpreted by the merchant.
 
One important aspect of customization that should be addressed is that flexibility like this comes with a price. While it does imply that you collect extra information for a product, you can lose certain inventory functionality when you use it. If you need to customize a product with four options, Shopify only has three. So you could decide to collect the fourth option with a form field and use the built-in options for the other three. When you make this choice, you lose the ability to keep track of inventory based on that fourth option. If price changes are involved, you have no choice but to use the built-in options to customize variants. This presents costs in terms of SKUs. There is also a limit of up to 100 customized variants. A virtually unlimited amount of customization is possible, but it should be applied to options that have no inherent cost or effect on inventory management.

### Image Switching ###

Shopify organizes a product by assigning it attributes like vendor, type and description. A product has no price but it does have variants. It has at least one default variant. Each variant has a price and can be setup within inventory to have options. A product also has images. You can upload multiple images for a product but there is no connection for those images directly to the variants! 

If a merchant wants to present a product that comes in five colours or perhaps seven different kinds of fabric, it is likely that they will want to change the main image in order to match the selected variant. For example, when looking at a t-shirt and selecting the colour blue, a customer expects the t-shirt image to change to blue. A common customization job concerns providing this to merchants. [Wall Glamour in the UK](http://http://www.wallglamour.co.uk) is a simple example of this. When choosing any kind of wall stickers, you can click a colour palette and the main image changes to match. Another example would be [Polka Dot What](http://www.polkadotwhat.com), where clicking the left or right leg changes the available thumbnail images and the main image. 

When there are twenty variants and twenty product images uploaded, how do you connect them together? Recently, Shopify introduced *alt* tag editing for product images. This assigns text to the images. Images with alt attribute text are great for search engine optimization (SEO). They can also be used as a hook so that when variants are selected, an image swap can occur. For novice theme developers, the Shopify alt tag approach is pretty good. You might sacrifice SEO results for image swapping to present a nicer images when customers select different variants. 

One cool aspect of swapping images is that all the images are readily available to Javascript from Liquid when you pass the product through the built-in Liquid *JSON* filter. Javascript code can access any image and use it as needed. With Javascript, you can easily substitute different product image sizes and place them anywhere on the screen. Once the Liquid phase of rendering a product is done, it can be left entirely to Javascript to make image swaps with nice effects like fades and other easing motions.

### Cross-Domain Support with JSONP, CORS or IFrame Elements ###

Shopify is a hosted platform and all merchant shops are known by their myshopify\_domain name combined with the *myshopify.com* root domain. Merchants can define a custom domain for their shop, however it can still be called using _myshop.myshopify.com_ as well. 

Since most apps will be hosted in the cloud, you may have to do an AJAX call to an app on a different domain. How can one do this? Cross-domain AJAX is possible using both CORS and JSONP. You can also use an HTML *iframe* element to embed a form in a shop. The cross-domain AJAX request is common and can be quite useful. It can serve as a support mechanism for sites that need it. To avoid JSONP and just use straight up Ajax, an app needs to be created on a subdomain of the main shop, like _app.mygreatshop.com_. 

### Special Invites ###

Before the App Store and lockdown apps like Gatekeeper were available, it was really difficult to keep a shop locked down so that only registered customers could access it. It is possible to build apps that present a form to capture a customer's email address and perhaps a secret code. The code and the URL of the app can be presented to the customers you want to be able to access the shop. Each customer that types in the correct secret code and their email address can trigger the app to unlock the password protected shop, using credentials only known to the app. If the app is on a subdomain of the shop, it can set the needed session cookie for a customer and seamlessly transfer them into an otherwise locked shop.

The customer account scripts provided with Shopify can also be setup to provide a modicum of security. There are a few supported patterns for customer account creation with Shopify. It remains to be seen if this has resulted in a better customer experience. 