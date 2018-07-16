# trackML

*A Rails web-app to manage your machine learning experiments* `work in progress`

- **Peace of mind**: everything is saved and easily accessible so you can remember what you tried and how well it performed
- **Visibility**: quickly compare different models and share results with collaborators
- **Control**: you keep control of your data, whether you want to keep it on your local machine or your servers


## Getting started

### Run trackML locally

You will need to have Rails 5 installed on your machine.
Then you can just start a local server by running `rails s`, open 
your favorite browser to `http://localhost:3000/` and start creating 
projects and models.

Running your trackML server locally is a good way to keep control of your 
data, but remember you'll have to start the server before logging your experiments with the Python client.

If you want to run trackML locally while running your experiments (model training etc) on a different machine, you can expose your localhost server
with a public url with [ngrok](https://ngrok.com/).


### Deploy to Heroku

*coming soon*

## Features

- Organize your experiments with projects and models
- Quickly visualize the best performances reached by each model
- Monitor hyper-parameter tuning with several metrics
- Compare hyper-parameters and how they influence your results
- Export logs to CSV for deeper anaylsis with your favorite language
- More to come...

## Python client

[trackml-client-py](https://github.com/sds-dubois/trackml-client-py) is a client library to use trackML in Python.

## Coming soon

- Deployment with Heroku
- User authentication

And more...


## License

[MIT License](LICENSE.md)

## Credits

- Graphs are made with [chartkik](https://github.com/ankane/chartkick)
- Bootstrap theme from [bootswatch](https://github.com/thomaspark/bootswatch/)

