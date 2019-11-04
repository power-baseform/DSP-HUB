# About

The Power Digital Social Platform's HUB software is a backend management system for creating and managing content for one or several Power Water Communities DSPs. The HUB  allows authorized users (DSP admins) to configure a DSP's public website (the PUB) and mobile app (the MOB), manage their content, manage users, change their customization layers such as social participation, gamification, web layouts, and present engagement KPIs. Training videos on how to use the DSP-HUB are avaliable here: vimeo.com/channels/powertraining .
Repositories are equally available for the PUB and MOB.

For details about the HUB software's specific design and implementation, please check the included documentation (pdf).

# Background

The Power Water Communities DSP open-source software repository was created and is curated by the Power (Political and social awareness on water environmental challenges) Project and its partners, with development led by Baseform. The Digital Social Platform (DSP) is the project’s main tool to be made available to cities, utilities, public agencies or water-related interest groups, aiming at an active and relevant contribution to the creation of digital communities around themes specifically related to water and the quality of life of local populations.

Such DSPs are typically aimed at community members, activists, volunteers, municipal officials and representatives, water professionals and experts, as well as regional, national or international-level policy-makers, politicians and other stakeholders. A specific instance of the DSP is made available through a dedicated Water Community website and an accompanying mobile app, designed to fulfill both informative, engagement and participatory roles.

The Power Water Communities DSP includes three related but separate software repositories: HUB, a content management back-end; PUB, the web front-end for the general public; and MOB, its mobile app counterpart.   

POWER is a Research and Innovation Action, supporting the EIP Water Action Group, NetwercH2O and City Blueprints. It is funded by the European Commission under the H2020 Programme, Call ICT10-2015 ‘Collective Awareness Platforms for Sustainability and Social Innovation’ - Topic c) Digital Social Platforms (DSP). For more information and to access any of the existing Power Water Communities DSPs, please go to http://www.power-h2020.eu

# Contributing

Check out our [contributing guidelines](https://github.com/power-baseform/DSP-HUB/blob/master/CONTRIBUTING.md) for ways to offer [feedback](https://bugzilla.baseform.com/) and contribute.

# Licenses

Content is released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) software is released under [GPLv3](https://choosealicense.com/licenses/gpl-3.0/) complete details, including attribution guidelines, contribution terms, and software and third-party licenses and permissions.

# Build

To run the DSP-HUB, you first need to install [RVM](https://rvm.io/rvm/install) (Ruby Version Manager) in order to get the correct Ruby version.

```bash
rvm install ruby-2.4.0
rvm use 2.4.0
```

Then you will need to have a Postgres instance running locally – you can learn how to do that [here](https://www.postgresql.org/docs/9.3/static/tutorial-install.html).

After that, you are ready to run the Ruby app.
Go to the project root and start by running:

```bash
gem install bundler
bundle install
```

At that point, you need to create the database

```bash
rake db:create
rake db:schema:load
rake db:seed
```

After that, just run :

```bash
rails server
```

And the server should be available at localhost:3000 by default.
