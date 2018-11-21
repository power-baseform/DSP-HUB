# About

The Power DSP's HUB software is a backend management system for creating and managing content of the POWER project. The HUB tier allows authorized users to manage content of one or more of the digital social platforms of the Power ecosystem. As a backend tier, HUB allows to change DSP’s customization layers such as social participation, gamification, web layouts as well as presenting engagement KPI’s.

# Background

Power Project open-source software repository was created and are curated by the Power (Political and social awareness on water environmental challenges) Project members and partners of which Baseform is leading the software development of this Digital Social Platform. The Digital Social Platform includes three related but separate software repositories and projects: HUB, the management backend; PUB, the web frontend for the general public and MOB, the mobile app counterpart. 

For more information, check out http://www.power-h2020.eu

# Contributing

Check out our [contributing guidelines](https://github.com/power-baseform/DSP-HUB/blob/master/CONTRIBUTING.md) for ways to offer [feedback](https://bugzilla.baseform.com/) and contribute.

# Licenses

Content is released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) software is released under [GPLv3](https://choosealicense.com/licenses/gpl-3.0/) complete details, including attribution guidelines, contribution terms, and software and third-party licenses and permissions.

# Build

To run the DSP-HUB you first need to install [RVM](https://rvm.io/rvm/install) (Ruby version manager) in order to get the correct ruby version.

```bash
rvm install ruby-2.4.0
rvm use 2.4.0
```

Then you need to have a postgres instance running locally, you can learn how to do that [here](https://www.postgresql.org/docs/9.3/static/tutorial-install.html).

After that you are ready to run the ruby app.
Go to the project root and start by running:

```bash
gem install bundler
bundle install
```

Then you need to create the database

```bash
rake db:create
rake db:schema:load
rake db:seed
```

After that just run :

```bash
rails server
```

And the server should be available in localhost:3000 by default.
