## How to Handle Webhook Requests

This is a big one and important topic. If Shopify doesn't receive a 200 OK status response within 10 seconds of sending an App a WebHook, Shopify will assume there is a problem and will mark it as a failed attempt. Repeated attempts will be made for up to 48 hours. A common cause for failure is an App that performs some complex processing when it receives a WebHook request before responding. When processing WebHooks a quick 200 OK response that acknowledges receipt of the data is more essential.

Here's some pseudocode demonstrating what I mean:

@@@ ruby
  def handle_webhook request
    process_data request.data    # Note that the process_data call could take a lot of time
    status 200
  end
@@@

To make sure that you don't take too long before responding you should defer processing the WebHook data until *after* the response has been sent. Delayed or background jobs are perfect for this.

Here's how your code could look:

@@@ ruby
  def handle_webhook request
    schedule_processing request.data    # this takes no time so the response is quick
    status 200
  end
@@@

Even if you're only doing a small amount of processing, there are other factors to take into account. On-demand cloud services such as Heroku or PHPFog will need to spin up a new processing node to handle sporadic requests since they often put Apps to sleep when they are not busy. This can take several seconds. If your App is only spending five seconds processing data it'll still *fail* if the underlying server took five seconds to start up.

### The Interesting World of WebHooks

Shopify does a fine job of introducing and explaining WebHooks on the wiki, and there are some pretty nifty use cases provided. The *best practices* are essential reading and should be thoroughly understood to get the most out of using WebHooks. In my experience with Webhooks I have run into all sorts of interesting issues so I will dedicate some effort to explaining them from an App developer perspective.

[Shopify WebHooks Documentation](http://wiki.shopify.com/WebHook#How_Should_I_Handle_Webhook_Requests)

When you are dealing with Shopify Webhooks you are in the Email & Preferences section of a shop. You can setup a WebHook using the web interface. Pick the type of WebHook you want to use and provide a URL that will be receiving the data. For those without an App to hook up to a shop there are some nifty WebHook testing sites available that are free to use. Let's take one quick example and use RequestBin. The first thing I will do is create a WebHook listener at the [Request Bin](http://requestb.in/ "RequestBin") website.

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/request_bin_home2.png" alt="Create a new RequestBin for your WebHook" />
</div>

Pressing the *Create a RequestBin* button creates a new WebHook listener. The result is a generated URL that can be used for testing. Note that one can also make this test private so that only you can see the results of WebHooks sent to the RequestBin. 

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/request_bin_created2.png" alt="Newly Created RequestBin" />
</div>

The RequestBin listener is the URL that can be copied into the Shopify Webhook creation form at the shop's Email & Preferences administration section. http://www.postbin.org/155tzv2 where the code **155tzv2** was generated just for this test. Using the WebHook create form one can pick the type of WebHookto test and specify where to send it. 

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_created2.png" alt="WebHook Created in Shopify Email and Preferences" />
</div>

When the WebHook has been created you can send it to the RequestBin service any time by clicking on the **send test notification** link and standing by for a confirmation that it was indeed sent. 

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_testable2.png" alt="Testable WebHook" />
</div>

The ability to delete a WebHook as well as test it in the shop has on occasion burned me. In my haste to deal with a situation involving WebHooks I have been guilty of accidentally pressing the trashcan icon and removing a WebHook that should *never have been removed*. Ooops! It can take only seconds of carelessness to decouple a shop set for live e-commerce sales from a crucial App running and connected to the shop. Be careful when clicking around these parts!

Sending a test is easy, and the result should be immediately available in RequestBin. My example shows a test order in JSON format. 

<div class="figure">
<img src="file://localhost/Users/dlazar/Pictures/Shopify%20E-Book/webhook_results2.png" alt="WebHook Results" />
</div>

Looking closely at the sample order data which is in JSON format we see there is a complete test order to work with. We have closed the loop on the concept of creating, testing and capturing WebHooks. The listener at RequestBin is a surrogate for a real one that would exist in an App but it can prove useful as a development tool. 

For the discussion of WebHook testing we note that the sample data from Shopify is great for testing connectivity more than for testing out an App. Close examination of the provided test data shows a lot of the fields are empty or null. What would be nice is to be able send real data to an App without the hassle of actually using the Shop and booking test orders. For example, say you are developing an Application to test out a fancy order fulfillment routine a shop needs. 

You know you need to test a couple of specific aspects of an Order, namely:
1. Ensure the WebHook order data actually came from Shopify, and that you have the shop identification to work on. 
2. Ensure you do not already have this order processed as it makes no sense to process a *PAID* order two or more times.
3. You know you need to parse out the credit card used, and the shipping charges, and the discount codes used if any. 
4. There could be product customization data in the cart note or cart attributes that need to be examined.

This small list introduces some issues that may not be obvious to new developers to the Shopify platform. We can address each one and hopefully that will provide some useful insight into how you can structure an App to best deal with WebHooks from Shopify.

### WebHook Validation

When you setup an App in the Shopify Partner web application one of the key attributes generated by Shopify for the App is the authentication data. Each App will have an API key to identify it as well as a shared secret. These are unique tokens and they are critical to providing a secure exchange of data between Apps and Shopify. In the case of validating the source of a WebHook, both Shopify and the App can use the shared secret. When you use the API to install a WebHook into a Shop, Shopify clearly knows the identity of the App requesting the WebHook to be created, so Shopify uses the shared secret associated with the App and makes it part of the WebHook itself. Before Shopify sends off a WebHook created by an App it will be use the shared secret to compute a Hash of the WebHook payload and embed this in the WebHook's HTTP headers. Any WebHook from Shopify that has been setup with the API will have HTTP_X_SHOPIFY_HMAC_SHA256 in the Request's header. Since the App has access to the shared secret, the App can now use that to decode the incoming request. The Shopify team provides some working code for this.

@@@ ruby
SHARED_SECRET = "f10ad00c67b72550854a34dc166d9161"
def verify_webhook(data, hmac_header)
  digest  = OpenSSL::Digest::Digest.new('sha256')
  hmac    = Base64.encode64(OpenSSL::HMAC.digest(digest, SHARED_SECRET, data)).strip
  hmac == hmac_header
end
@@@

If we were to send the request body as the App received it to this little method, and the value of the HTTP_X_SHOPIFY_HMAC_SHA256 attribute in the request, it can calculate the Hash in the same manner as Shopify did before sending out the request. If the two computed values match, you can be assured the WebHook is valid and came from Shopify. That is why it is important to ensure your shared secret is not widely distrubuted on the Internet. You would lose your ability to judge between valid and invalid requests between Shopify and your App.

### Looking out for Duplicate Webhooks

As explained in the WebHook best practices guide, Shopify will send a WebHook out and then wait up to ten seconds for a response status. If that response is not received the WebHook will be resent. This continues until a 200 OK status is received ensuring that even if a network connection is down or some other problem is present Shopify will keep trying to get the WebHook to the App. The initial interval between retries of ten seconds is not practical for a large number of retries so the time interval between requests is constantly extended until the WebHook is only retried every hour or more. If nothing changes within 48 hours an email is sent to the App owner warning them their WebHook receiver is not working and that the WebHook itself will be deleted from the shop. This can have harsh consequences, mitigated by the fact that the email should be sufficient to alert the App owner to the existence of a problem. 

Assuming all is well with the network and the App is receiving WebHooks it is entirely possible that an App will receive the odd duplicate WebHook. Shopify is originating WebHook requests in a Data Center and there are certainly going to be hops through various Internet routers as the WebHook traverses various links to your App. If you use the tracert command to examine these hops you can see the latency or time it takes for each hop. Sometimes, an overloaded router in the path will take a long time to forward the needed data extending the time it takes for a complete exchange between Shopify and an App. Sometimes the App itself can take a long time to process a WebHook and respond. In any case a duplicate is possible and the App might have a problem unless it deals with the possibility of duplicates. 

A simple way to deal with this might be to have the App record the ID of the incoming WebHook resource. For example, on a paid order if the App knows apriori that order 123456 is already processed, any further orders detected with the ID 123456 can be ignored. Turns out in practice this is not a robust solution. A busy shop can inundate an App with orders/paid WebHooks and at any moment no matter how efficient the App is at processing those incoming WebHooks, there can be enough latency to ensure Shopify sends a duplicate order out. 

A robust way to handle WebHooks is to put in place a Message Queue (MQ) service. All incoming WebHooks should be directed to a message queue. Once an incoming WebHook is successfully added to the queue the App simply returns the 200 Status OK response to Shopify and the WebHook is completed. If that process is subject to network latency or other issues it makes no difference as the queue welcomes any and all WebHooks, duplicates or not. 

With an App directing all incoming WebHooks to an queue a queue worker process can be used to *pop off* WebHooks in the queue for processing. There is no longer a concern over processing speed and the App can do all the sophisticated processing it needs to do at it's leisure. It is possible to be certain whether an orders/paid WebHook has been processed already or not. Duplicated WebHooks are best taken care of with this kind of architecture.

### Parsing WebHooks

Shopify provides WebHook requests as XML or as JSON. Most scripting languages used to build Apps have XML parsers that can make request processing routine. With the advent of NoSQL databases storing JSON documents such as CouchDB and MongoDB many Apps take advantage of this and prefer all incoming requests to be JSON. Additionally one can use Node.js om the server to process WebHooks and so JSON is a natural fit for those applications. Since the logic of searching a request for a specific field is the same for both formats, it is up to the App author to choose the format they prefer. 

### Cart Customization

Without a doubt one of the most useful but also a more difficult aspect of front end Shopify development is in the use of the cart note and cart attribute features. They are the only way a shop can collect non-standard information directly from a shop customer. Any monogrammed handbags, initialed wedding invitations, engraved glass baby bottles etc. will have used the cart note or cart attributes to capture this information and pass it through the order process. Since a cart note or cart attribute is just a key and value, the value is restricted to a string. A string could be a simple name like "Bob" or it could conceivably be a sophisticated Javascript Object like "[{"name": "Joe Blow", "age" : "29", "dob": "1958-01-29"},{"name": "Henrietta Booger", "age" : "19", "dob": "1978-05-21"},..{"name": "Psilly Psilon", "age" : "39", "dob": "1968-06-03"}]". In the App, when we detect cart attributes with JSON, we can parse that JSON and reconstitute the original objects embedded in there. In my opinion it is this pattern of augmenting orders with cart attributes, passing them to Apps by WebHook and then parsing out the special attributes that has made it possible for the Shopify platform to deliver such a wide variety of e-commerce sites while keeping the platform reasonably simple. 
