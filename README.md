# Contextual Puppet Environment

## Overview

Contextual is an idea that a few friends of mine and I were prototyping but it turned out that there was a patent on the idea.

All the code will be added to github just for reuse purposes. Any feedback on how to improve this is welcome, i'm new to it and trying to learn.

## Requirements
To use this environment you will need:

1. ### [Vagrant](https://www.vagrantup.com/)
Download and install vagrant from [here](https://www.vagrantup.com/)

2. ### [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
Download and install VirtualBox from [here](https://www.virtualbox.org/wiki/Downloads)

3. ### Puppet dependancies
	1. [Ruby](https://www.ruby-lang.org/en/)

		Ensure you have ruby installed by typing this command in the terminal.
		```
		ruby -v
		```
		> If it doesnt give you a ruby version then you can download and install ruby from [here](https://www.ruby-lang.org/en/)

	2. [Bundler](http://bundler.io/)

		Simply enter this command in the terminal.

       3. Install gems

                Simply enter this command in the terminal.
                ```
                bundle install
                ```
	4. Run librarian-puppet

		Run the command from this cloned projects directory in the terminal.

		```
		bundle exec librarian-puppet install
		```

## Lets get started

When all of the requirements are install, all you have to do to run the project is go to the directory in the terminal and run:

```
vagrant up
```

## Continuing development

- To delete everything after doing a vagrant up do a
	```
	vagrant destroy
	```

- If you make a change to a .pp file and want to test it do a
	```
	vagrant provision
	```

- If you make a change to the vagrant file do a
	```
	vagrant reload --provision
	```

and as always Google is your friend.
