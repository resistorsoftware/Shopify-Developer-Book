## How Should I Handle Webhook Requests? ##

This is a big one. As explained above, if Shopify doesn't receive a response within 10 seconds of sending a webhook, it assumes there's a problem and marks it as failed.

A common cause for this is an app that does some processing when it receives a webhook request before responding. In the normal web-app world this is desired as you need to send data back to the user. When processing webhooks on the other hand, all that's needed is a quick 200 OK response that acknowledges receipt of the data.

Here's some pseudocode demonstrating what I mean:

func handle_webhook(request)
  process_data(request.data)
  respond(200)
end
To make sure that you don't accidentally run over the timeout limit, you need to defer any processing processing until *after* the response has been sent. In Rails, Delayed Jobs are perfect for this.

Here's how your code should look:

func handle_webhook(request)
  schedule_processing(request.data)
  respond(200)
end
Even if you're only doing a small amount of processing, there are other factors to take into account. On-demand services such as Heroku or PHPFog sometimes need to spin up a new node to handle the request, and this action can take several seconds. Even if your app is only spending five seconds processing data it'll still 'fail' if the underlying server took six seconds to start up.

### The interesting world of WebHooks ###

Shopify does a fine job of introducing Webhooks, and indeed there are some pretty nifty use cases they provide as well. They have a best practices too, which needs to be digested. In my experiences with Webhooks I have run into all sorts of interesting issues, so I will dedicate some time and space to explaining them in my own way. First you should really go through the Shopify explanations available here

[Shopify WebHooks Documentation](http://wiki.shopify.com/WebHook#How_Should_I_Handle_Webhook_Requests)

First off, when you are dealing with Shopify Webhooks you are in the Email & Preferences section of a Shopify Admin site. You can setup a webhook very simply there. Just pick the type of webhook you want to respond and type in a URL pointing at the receiver. For the purposes of those without an App to quickly hook up to a shop, there are some nifty webhook testing sites out there.  Let's take one quick example with RequestBin. The first thing I will do is create a WebHook listener at the  [Request Bin](http://requestb.in/ "RequestBin") website.

![Create a new RequestBin for your WebHook](file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/request_bin_home.png)
 
Pressing the *Create a RequestBin* button creates a new WebHook listener for me. I am assigned a URL that I can use for testing. Note that I can also make this private so that only I can see the results of WebHooks sent to the RequestBin. 

![Newly Created RequestBin](file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/request_bin_created.png)

My listener is now the nice simple URL that I can copy into the Shopify Webhook creation form at my Shop's Email & Preferences administration section. http://www.postbin.org/155tzv2 where the code **155tzv2** was generated just for me. Flipping over to my Shopify Admin, I can create the webhook I want to test, now that I know where to send it. 

![WebHook Created in Shopify Email and Preferences](file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_created.png)

Once created, I can now send a webhook to this little service any time I want by clicking on the **send test notification** link and standing by for a confirmation that it was indeed sent. 

![Testable WebHook](file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_testable.png)

The ability to delete a WebHook as well as test it in the Shopify Admin interface has on occasion burned me. In my haste to deal with a situation involving WebHooks I have been guilty of accidentally pressing the trashcan icon and removing a WebHook that should *never have been removed*. Ooops! It can take only seconds of carelessness to decouple a shop set for live e-commerce sales from a crucial App running and connected to the shop. Be careful when clicking around these parts!

Sending a test is easy, and the result should be immediately available in RequestBin. My example shows a test order in JSON format. 

![WebHook Results](file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_results.png)

Looking closely at the sample order JSON there is a complete test order to work with. We have closed the loop on the concept of creating, testing and capturing WebHooks. The listener  at RequestBin is a surrogate for a real one that would exist in an App but it can prove useful as a development tool. 

For the discussion of WebHook testing we have to agree that the sample data from Shopify is great for testing connectivity more than for testing out an App. Close examination of the provided test data shows a lot of the fields are empty or null. What would be nice is to be able send real data to an App without the hassle of actually using the Shop and booking test oreders. For example, say you are developing an Application to test out a fancy order fulfillment routine a shop needs. 

You know you need to test a couple of specific aspects of an Order, namely:
1. Ensure the WebHook order data actually came from Shopify, and that you have the Shop identification to work on. 
2. Ensure you do not already have this Order processed as it makes no sense to process a PAID Order two or more times.
3. You know you need to parse out the credit card used, and the shipping charges, and the discount codes used if any. 
4. There could be Product customization data in the cart note or cart attributes that need to be examined.

This small list introduces some issues that may not be obvious to new developers to the Shopify platform. We can address each one and hopefully that will provide some useful insight into how you can structure an App to best deal with WebHooks from Shopify.

### WebHook Validation ###

When you setup an App in the Shopify Partner's web application, one of the key attributes generated by Shopify for the App is the Authentication data. Each App will have an API Key to identify it, as well as a shared secret. These are unique tokens and they are critical to providing secure exchanges of data between Apps and Shopify. In the case of validating the source of a WebHook, both Shopify and the App can use the shared secret. When you use the API to install a WebHook into a Shop, Shopify clearly knows the App requesting that the WebHook be created, so Shopify in turn grabs the shared secret associated with the App and makes it available to the WebHook. Before Shopify sends off a real WebHook, it will be able to use the shared secret to compute a Hash of the WebHook payload and embed this in the WebHook HTTP headers. Any WebHook from Shopify that has been setup with the API will have HTTP_X_SHOPIFY_HMAC_SHA256 in the Request's header. Since the App has access to the shared secret, the App can now use that to decode the incoming request. The Shopify team provides some working code for this.

@@@ ruby
SHARED_SECRET = "f10ad00c67b72550854a34dc166d9161"
def verify_webhook(data, hmac_header)
  digest  = OpenSSL::Digest::Digest.new('sha256')
  hmac    = Base64.encode64(OpenSSL::HMAC.digest(digest, SHARED_SECRET, data)).strip
  hmac == hmac_header
end
@@@

If we were to send the request body as the App received it to this little method, and the value of the HTTP_X_SHOPIFY_HMAC_SHA256 attribute in the request, it can calculate the Hash in the same manner as Shopify did before sending out the request. If the two computed values match, you can be assured the WebHook is valid and came from Shopify. That is why it is important to ensure your shared secret is not widely distrubuted on the Internet. You would lose your ability to judge between valid and invalid requests between Shopify and your App.

### Looking out for Duplicate Webhooks ###

As explained in the WebHook best practices guide, Shopify will send a WebHook out, and then wait up to ten seconds for a response status of 200 OK. If that response is not received, the same WebHook will be resent. This continues until a 200 OK status is received ensuring that even if a network connection is down or some other problem is present, Shopify will keep trying to get that WebHook to the App. Of course, the ten seconds is not practical, so the time between requests is constantly extended until the WebHook is only retried every hour or more. If nothing changes within 48 hours, an email is sent to the App owner warning them their WebHook receiver is not working, and that the WebHook itself will be deleted from the Shop. This can have harsh consequences, mitigated by the fact that the email should be sufficient to alert the App owner to the existence of a problem. 

Assuming all is well with the network, and the App is receiving WebHooks, it is entirely possible that an App will receive duplicate WebHooks. Shopify is originating WebHook requests in a Data Center and there are certainly going to be hops through various Internet routers as the WebHook traverses various links to your App. If you use the tracert command to examine these events, you can see the latency or time it takes for each hop. Sometimes, an overloaded router in the path will take a long time to forward the needed data, extending the time it takes for a complete exchange between Shopify and an App. Sometimes, the App itself can take a long time to process a WebHook and respond. In any case, a so-called duplicate is issued and now the App might have a problem. 

A simple way to deal with this might be to have the App record the ID of the incoming WebHook resource. For example, on a paid order, if the App knows apriori that Order 123456 is already processed, if that Orders is detected by the WebHook processing paid orders, it can be ignored as a duplicate. This is not really a terribly robust solution. A busy Shop can inundate an App with orders/paid WebHooks and at any moment, no matter how efficient the App is at processing those incoming WebHooks, there can be enough latency to ensure Shopify sends a duplicate order out. 

A more robust way to handle this is for an App to take advantage of a Message Queue (MQ) service. All incoming WebHooks can be directed to a MQ. Once an incoming WebHook is successfully added to the MQ, the App simply returns the 200 Status OK response to Shopify and the WebHook is completed. If that process is subject to network latency or other issues, it really makes no difference as the MQ welcomes any and all WebHooks, duplicates or not. 

Having now built our App to direct all incoming WebHooks to an MQ, a process has to be used that pops off any new WebHooks in the MQ for processing. There is no longer any concern over processing speed and the App can now do all the sophisticated processing it needs to do. We can now be certain if we have seen an orders/paid WebHook before or not. Duplicated WebHooks are best taken care of with this kind of architecture.

### Parsing WebHooks ###

Shopify provides WebHook requests as XML or as JSON. Most scripting languages used to build Apps have XML parsers that can make request processing routine. With the advent of NoSQL databases storing JSON documents such as CouchDB and MongoDB, many Apps take advantage of this and prefer all incoming requests to be JSON. Additionally, one can use Node.js to process WebHooks and so JSON is a natural fit for those applications too. Since the logic of searching a request for a specific field is the same for both formats, it is up to the App author to choose the one they prefer. 

### Cart Customization ###

Without a doubt one of the most useful but also the most difficult aspects of front-end Shopify development is in the use of the cart note and cart attribute features. They are the only way a Shop can collect non-standard information directly from a Shop customer. Any monogrammed handbags, initialed wedding invitations, engraved glass baby bottle etc. will have used the cart note or cart attributes to capture this information as pass it through the order process. Since a cart note or cart attribute is just a key and value, the value is restricted to a string. A string could be a simple name like "Bob" or it could conceivably be a sophisticated Javascript Object like "[{"name": "Joe Blow", "age" : "29", "dob": "1958-01-29"},{"name": "Henrietta Booger", "age" : "19", "dob": "1978-05-21"},..{"name": "Psilly Psilon", "age" : "39", "dob": "1968-06-03"}]". In the App, when we detect cart attributes with JSON, we can parse that JSON and reconstitute the original objects embedded in there. In my opinion it is this feature of Shopify that has made it possible for the Shopify platform to deliver such a wide variety of e-commerce sites while keeping the platform reasonably simple. 

  
  
