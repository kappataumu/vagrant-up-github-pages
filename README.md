This repository consists of a Vagrant configuration plus provisioning Bash script that let you easily `vagrant up` a local mirror of any Github Pages repository. It accompanies my blog post: [Vagrant, Jekyll and Github Pages for streamlined content creation](http://kappataumu.com/articles/vagrant-jekyll-github-pages-streamlined-content-creation.html).

Getting started is straightforward:

```
$ git clone https://github.com/kappataumu/vagrant-up-github-pages.git
$ cd vagrant-up-github-pages
$ export REPO='https://github.com/kappataumu/kappataumu.github.com.git'
$ vagrant up
```

That's all there is to it. Now you can:

1. Access your website by browsing to `http://localhost:4000`.
2. Edit files locally, inside the `www` subfolder.
3. Simply `vagrant up` directly in the future to start the guest (no bootstraping needed).

Jekyll will: 

1. Recompile everything when changes are detected.
2. Log all activity in `/home/vagrant/jekyll.log`.
3. Automatically start serving your repo on every `vagrant up`.

