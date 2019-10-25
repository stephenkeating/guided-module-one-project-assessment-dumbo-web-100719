# Project Title: Ghibli Delivery Service

This project is meant to foster a sense of community and oneness, while encouraging taking personal responsibility for the individual roles we each play in our communities and on this planet as whole. The goal of the game is to save the Forest by collecting enough magic seeds to plant and counter the damages caused by the warring armies.

### Prerequisites
What things you need to install the software and how to install them
We ran a bundle install in order to get the bare-bones code working. Rake and ActiveRecord were the two most essential gems in completing our project. Tty-prompt allowed us to create a dynamic user interface, essentially allowing it to feel like a real game. We used afplay to add music through pid. We used an image magick gem bundle in order to add images to our pages. 

If the rmagick gem doesn't install for you, check the Gemfile for instructions.

## Running the tests
We ran tests by simply playing the game and watching for instances where the game was not behaving how we wanted it to. Additionally, we used rake console and binding.pry to dive into in a more in depth look at our code.

### Struggles
- ‘ttty-prompt’ gem: 
-  One thing we didn’t do well was researching the full extent of what this gem could do. Therefore we ran into a lot of bugs because we didn’t utilize all of the gems properties.
-  We had to debug a lot of code because of all the class variables we created, instead of utilizing tty-prompt

- self-referential model:
- We had issues establishing the models and making sure they followed a single source of truth

- Too many variables:
- Because we didn’t utilize tty-prompt properly, we had to create many class variables which later caused some confusion. It also didn’t allow us to dry up the code well. 

### Proposed 2.0 Features
- In the order to make the application more dynamic and robust, we wanted to implement tty-prompt’s multi select feature so that customers can purchase multiple items
- To make the user interface more streamlined, we wanted to make all the image sizes more consistent 

- ‘image magick’:
- In order to use the other gems for images, we had to utilize image magick, which is pretty outdated so some of the gems that relied on it broke

## Authors

* **Alina Arakelyan** - Co-Author –
* **Stephen Keating** - Co-Author –
* **Vannida Lim** - Co-Author –

## Acknowledgments

* Studio Ghibli 
* Jacky Feng for lots of amazing advice
* Flatiron School, teachers, and classmates

