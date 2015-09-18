CutePets
========

Post a random adoptable pet from a shelter to a twitter feed
------------------------------------------------------------

Based off of Code for America's [CutePetsDenver](https://github.com/codeforamerica/cutepetsdenver) made by Team Denver.

CutePetsDenver Twitter feed: [https://twitter.com/CutePetsDenver](https://twitter.com/CutePetsDenver)

![Cutest Pet](https://pbs.twimg.com/media/CO8Jf-kW8AAyw-Q.jpg)

## Get Your Own!
We've tried to make this as simple as possible. You'll be setting up a few _free_ online accounts, connecting them together, then you'll get your very own CutePets twitter bot. Its painless and takes about an hour. Lets go.


### Instructions
Summary:
* We'll find an animal shelter we want to help get pets adopted from.
* We'll set up a new Twitter account for these CutePets.
* We'll create a bot that regularly posts the pets pictures and info.


#### Petharbor
We're scraping info from Petharbor to make our Twitter bot.

1. Find the petharbor shelter id. The shelter id can be found near the end of the url, before the pet id, when    clicking on the short link for a pet through petharbor.com. i.e. the shelter id in [http://www.petharbor.com/pet.asp?uaid=BRKL.A034281](http://www.petharbor.com/pet.asp?uaid=BRKL.A034281) is BRKL.
2. Figure out which pet types your shelter has. Do a search on [petharbor.com](http://www.petharbor.com) narrowed down by your shelter. It should be `cat` `dog` or `others`.
3. We'll need this info in a few minutes, keep it around.


#### Make a new cute Twitter account
We'll make a new twitter account for the cutepets bot we want to make, then we'll set up the 'bot' side of things.

1. Create a [twitter account](https://twitter.com/signup) with the user name you'd like to have stream your pet tweets
2. Add your phone number. If your phone number ia already attached to your personal Twitter account, you've got two options:
    * Quickest way is to make a new temporary phone number using [Google Voice](https://www.google.com/voice).
    * Create the new twitter app on your personal accountthen transfer the API key to the new bot account [here](https://support.twitter.com/forms/platform) by selecting “I need to transfer an API key to another account”, filling out the form, and waiting a few days.
3. Accept the confirmation email that Twitter sends you.
4. Create a new [twitter app](https://apps.twitter.com/).
5. For Website, use the new twitter account you just made, https://twitter.com/cutepetstester or whatever
6. Leave callback url blank
7. Accept Developer Agreement
8. Go to the Keys & Access Token tab
7. Good work so far. We're going to need the Consumer Key (API Key) and the Consumer Secret (API Secret) for the next steps. So keep this window open or write them down.


#### Heroku Button
This will be our free rented computer in the sky. It will run the code that grabs the info about adoptable animals from Petharbor, then tells Twitter to tweet about them.

1. Heroku install instructions

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

6. Schedule tweets 
    1. Got to addons page and In the task field: `rake tweet_pet`.

7. Add your new deployment to the official list
    1. open [where.geojson](https://github.com/codeforamerica/CutePets/blob/master/where.geojson) and add your listing






## Set Up for Local Development

### Environment variables
Edit the local .env file by adding the appropriate config values. How to get Twitter/PetHarbor/Petfinder config variables is stated below.

### Run
`rake tweet_pet`


