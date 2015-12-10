CutePets
========

Post a random adoptable pet from a shelter to a twitter feed
------------------------------------------------------------

Based off of Code for America's [CutePetsDenver](https://github.com/codeforamerica/cutepetsdenver) made by Team Denver.

CutePetsDenver Twitter feed: [https://twitter.com/CutePetsDenver](https://twitter.com/CutePetsDenver)

![https://twitter.com/CutePetsDenver](http://i.imgur.com/TMKG80L.png)

## Get Your Own!
We've tried to make this as simple as possible. You'll be setting up a few _free_ online accounts, connecting them together, then you'll get your very own CutePets twitter bot. Its painless and takes about an hour. Lets go.


### Instructions
#### Summary:
* We'll find an animal shelter we want to help get pets adopted from.
* We'll set up a new Twitter account for these CutePets.
* We'll create a bot that regularly posts the pets pictures and info.

#### Requirements
This service requires a credit card to get set up. This card will **NOT** be charged.

#### Petharbor
We're scraping info from Petharbor to make our Twitter bot.

1. Search on [petharbor.com](http://www.petharbor.com) for a shelter in your town.
2. Find the petharbor shelter id. The shelter id can be found near the end of the url, before the pet id, when clicking on the short link for a pet through petharbor.com. i.e. the shelter id in [http://www.petharbor.com/pet.asp?uaid=BRKL.A034281](http://www.petharbor.com/pet.asp?uaid=BRKL.A034281) is `BRKL`.
3. Figure out which pet types your shelter has. Do a search on [petharbor.com](http://www.petharbor.com) narrowed down by your shelter. It should be `cat` `dog` or `others`.
4. We'll need this info in a few minutes, keep it around.

#### Facebook
1. Create a [facebook account](https://facebook.com) with the information you'd like to have when streaming your pet tweets
2. Get an [auth token](https://developers.facebook.com/tools/explorer).
3. On the **Get Token** drop-down, select it and choose **Get Access Token**, press on the tab for **Extended Permissions** and put a check in the box for **publish_actions**
4. Take note of the **Access Token** for environment set up below.


#### Twitter
First we'll make a new twitter account, then we'll set up the 'bot' side of things.

1. Create a [twitter account](https://twitter.com/signup) with the user name you'd like to have stream your pet tweets
2. Add your phone number. If your phone number ia already attached to your personal Twitter account, you've got two options:
    * Quickest way is to make a new temporary phone number using [Google Voice](https://www.google.com/voice) or [BurnerApp](http://www.burnerapp.com/).
    * Create the new twitter app on your personal accountthen transfer the API key to the new bot account [here](https://support.twitter.com/forms/platform) by selecting “I need to transfer an API key to another account”, filling out the form, and waiting a few days.
3. Accept the confirmation email that Twitter sends you.
4. Create a new [twitter app](https://apps.twitter.com/).
5. For Website, use the new twitter account you just made, https://twitter.com/cutepetstester or whatever
6. Leave callback url blank
7. Accept Developer Agreement
8. Go to the Keys & Access Token tab
9. Create an Access Token
10. Good work so far. We're going to need all of these values soon, so keep this window open or write them down.

#### Heroku
This is where we'll turn on a free rented computer in the sky. It will run the code that grabs the info about animals from Petharbor, then tells Twitter to tweet about them.

1. Create a [Heroku account](https://id.heroku.com/signup/www-header)
2. Confirm the email they send you.
3. Cick here -> [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/codeforamerica/cutepets)
4. Give your new app a unique name. Try the same name as your Twitter account.
5. Enter in the Twitter values
6. Add Facebook environment variables
    1. `heroku config:set oauth_access_token="your_access_token_goes_here"`
7. Enter in the Petharbor values
8. Enter in your credit card info. You will **NOT** be charged.
9. Click on "Manage App"
10. Click on "Heroku Scheduler"
11. Click on "Add new job"
12. In the text box, copy and paste `rake post_pet_twitter` or `rake post_pet_facebook` to post on Twitter and Facebook respectively
13. Keep the dyno size at free. Set the frequency at daily.
14. Choose the closest time to now to send your first tweet. You can check UTC time at [https://www.google.com/search?q=utc+time](https://www.google.com/search?q=utc+time).
15. Wait for it, wait for it.
16. Yeah! You did it!

#### Github
Great work. Now, tell us which city you made a cutepets bot for. We do this by sending in a Pull Request with our twitter bot's name and location.

1. Make a new [Github Account](https://github.com/join). Choose the **free** account plan.
2. Check out the map on the [CutePets Repo](https://github.com/codeforamerica/CutePets/blob/master/where.geojson)
3. We want to add our own point to the map. We'll need the latitude and longitude for our city. Try using [Bing Maps](https://www.bing.com/maps/) or [http://www.latlong.net/](http://www.latlong.net/) to easily find them.
4. Edit the where.geojson file using [this link](https://github.com/codeforamerica/CutePets/edit/master/where.geojson).
5. Add in your twitter bot's name and location using the format below. Note that the negative longitude goes first. Be sure to have that comma at the very end too.
```
		{
			"type": "Feature",
			"properties":
			{
				"twitter" : "http://twitter.com/CutePetsAdamsCo"
			},
			"geometry":
			{
				"type": "Point",
				"coordinates": [ -104.871902 , 39.891651 ]
			}
		},
```
6. Click "Propose Changes" at the bottom of the page.
7. Click "Create Pull Request"
8. That's it! Thanks!
