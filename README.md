# Weather

Query an endpoint at Wunderground for weather information.

## Features

- Display the inches of rain that have accumulated today.

## Usage

1. run `$ source .env`
1. run `$ mix run -e 'Weather.CLI.run(["conditions/q/CA/San_Francisco.json"])'`,
optionally using whatever state/city you want.

## Installation

1. Sign up for an API key at https://www.wunderground.com/.
1. Create a .env file, using the .env.sample file as a guideline.
1. Set the variable WUNDERGROUND_API_KEY in .env to your
   wunderground API key.
