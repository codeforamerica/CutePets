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


#### Petharbor
We're scraping info from Petharbor to make our Twitter bot.

1. Search on [petharbor.com](http://www.petharbor.com) for a shelter in your town.
2. Find the petharbor shelter id. The shelter id can be found near the end of the url, before the pet id, when clicking on the short link for a pet through petharbor.com. i.e. the shelter id in [http://www.petharbor.com/pet.asp?uaid=BRKL.A034281](http://www.petharbor.com/pet.asp?uaid=BRKL.A034281) is `BRKL`.
2. Figure out which pet types your shelter has. Do a search on [petharbor.com](http://www.petharbor.com) narrowed down by your shelter. It should be `cat` `dog` or `others`.
3. We'll need this info in a few minutes, keep it around.


#### Make a new cute Twitter account
First we'll make a new twitter account, then we'll set up the 'bot' side of things.

1. Create a [twitter account](https://twitter.com/signup) with the user name you'd like to have stream your pet tweets
2. Add your phone number. If your phone number ia already attached to your personal Twitter account, you've got two options:
    * Quickest way is to make a new temporary phone number using [Google Voice](https://www.google.com/voice).
    * Create the new twitter app on your personal accountthen transfer the API key to the new bot account [here](https://support.twitter.com/forms/platform) by selecting “I need to transfer an API key to another account”, filling out the form, and waiting a few days.
3. Accept the confirmation email that Twitter sends you.
4. Create a new [twitter app](https://apps.twitter.com/).
<<<<<<< HEAD
5. For Website, use the new twitter account you just made, https://twitter.com/cutepetstester or whatever
6. Leave callback url blank
7. Accept Developer Agreement
8. Go to the Keys & Access Token tab
7. Good work so far. We're going to need the Consumer Key (API Key) and the Consumer Secret (API Secret) for the next steps. So keep this window open or write them down.


#### Heroku Button
This will be our free rented computer in the sky. It will run the code that grabs the info about adoptable animals from Petharbor, then tells Twitter to tweet about them.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)














1. Heroku install instructions




6. Schedule tweets
    1. Got to addons page and In the task field: `rake tweet_pet`.

=======
5. On the API key tab for the Twitter app, modify permissions so the app can **Read and Write**. *Note: It's important to change permissions to Read/Write before generating the access token. The access token is keyed for the specific access level and will not be updated when changing permissions.*
6. Create an access token. On the API Key tab in Twitter for the app, click **Create my access token**
7. Take note of the values for environment set up below.

### Heroku
1. Create a [Heroku account](https://id.heroku.com/signup/www-header)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

1. Download and install the [Heroku Toolbelt](from: https://toolbelt.heroku.com).
2. Create heroku project: `heroku create [app name]`
3. Push code: `git push heroku master`
4. Add Twitter environment variables
    1. `heroku config:set api_key="your_consumer_key_goes_here"`
    2. `heroku config:set api_secret="your_consumer_secret_key_goes_here"`
    3. `heroku config:set access_token="your_access_token_goes_here"`
    4. `heroku config:set access_token_secret="your_access_token_secret_goes_here"`
5. Configure pet datasource–you have two options (below). Search on Petfinder for your shelter and use that if you find it, otherwise look on PetHarbor. If you want to pull data from multiple shelters (choosing at random), make the shelter id variable a comma-separated list.
    1. **Petfinder**
        1. Register for an account at [petfinder.com](https://www.petfinder.com/) and then get your [API key](https://www.petfinder.com/developers/api-key). To find the shelter id, find a shelter's page on petfinder.com. The id is the last two letters followed by three numbers in the shelter page url. i.e. For this shelter page, [http://www.petfinder.com/shelters/CA154.html](http://www.petfinder.com/shelters/CA154.html), the shelter id is CA154.
        2. Add Petfinder environment variables.
            1. `heroku config:set petfinder_key="your_api_key_goes_here"`
            2. `heroku config:set petfinder_shelter_id="shelter_id_goes_here"`
            3. `heroku config:set pet_datasource="petfinder"`
    2. **PetHarbor**
        1. Find the petharbor shelter id. The shelter id can be found near the end of the url, before the pet id, when    clicking on the short link for a pet through petharbor.com. i.e. the shelter id in [http://www.petharbor.com/pet.asp?uaid=BRKL.A034281](http://www.petharbor.com/pet.asp?uaid=BRKL.A034281) is BRKL.
        2. Figure out which pet types your shelter has. Do a search on [petharbor.com](http://www.petharbor.com) narrowed down by your shelter. If your shelter has cats, include 'cat' in pet types. If your shelter has dogs or other animals, include 'dog' or 'others' in your pet types as well. When setting the petharbor_pet_types heroku config variable, pet types must be separated with spaces.
        3. Add Petharbor environment variables
            1. `heroku config:set petharbor_shelter_id="shelter_id_goes_here"`
            2. `heroku config:set petharbor_pet_types="cat dog others"`
            3. `heroku config:set pet_datasource="petharbor"`
6. Schedule tweets 
    1. Add the **Heroku Scheduler** add on: `heroku addons:create scheduler`
    2. Schedule tweets: `heroku addons:open scheduler`
    3. In the task field: `rake tweet_pet`.
>>>>>>> prep-for-summit-hackspace
7. Add your new deployment to the official list
    1. open [where.geojson](https://github.com/codeforamerica/CutePets/blob/master/where.geojson) and add your listing






## Set Up for Local Development

### Environment variables
Edit the local .env file by adding the appropriate config values. How to get Twitter/PetHarbor/Petfinder config variables is stated below.

### Run
`rake tweet_pet`
