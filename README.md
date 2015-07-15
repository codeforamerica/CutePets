CutePets
========

Post a random adoptable pet from a shelter to a twitter feed
-------------------------------------------------------------------

Based off of Code for America's [CutePetsDenver](https://github.com/codeforamerica/cutepetsdenver) made by Team Denver.

Example twitter feed: [http://www.twitter.com/ericapets](http://www.twitter.com/ericapets)

## Set Up for Local Development

### Environment variables
Edit the local .env file by adding the appropriate config values. How to get Twitter/PetHarbor/Petfinder config variables is stated below.

### Run
`rake tweet_pet`

## Deployment

### Twitter
1. Create a [twitter account](https://twitter.com/signup) with the user name you'd like to have stream your pet tweets
2. Accept the confirmation email that Twitter sends you.
3. Add and validate your phone number for your new Twitter account at https://twitter.com/settings/devices. *Note: If your phone number is already linked to another Twitter account, you can create the twitter app there and then transfer the API key to the bot account [here](https://support.twitter.com/forms/platform) by selecting “I need to transfer an API key to another account”, filling out the form, and waiting a few days.*
4. Create a new [twitter app](https://apps.twitter.com/).
5. On the API key tab for the Twitter app, modify permissions so the app can **Read and Write**. *Note: It's important to change permissions to Read/Write before generating the access token. The access token is keyed for the specific access level and will not be updated when changing permissions.*
6. Create an access token. On the API Key tab in Twitter for the app, click **Create my access token**
7. Take note of the values for environment set up below.

### Heroku
1. Create a [Heroku account](https://id.heroku.com/signup/www-header)
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
7. Add your new deployment to the official list
    1. open [where.geojson](https://github.com/codeforamerica/CutePets/blob/master/where.geojson) and add your listing
