This is a Vagrant configuration plus provisioning shell script that lets you easily `vagrant up` a local Jekyll-powered GitHub pages server. It accompanies my blog post: [Vagrant, Jekyll and Github Pages for streamlined content creation](http://kappataumu.com/articles/vagrant-jekyll-github-pages-streamlined-content-creation.html).

Getting started is straightforward:

```
$ git clone https://github.com/kappataumu/vagrant-up-github-pages.git
$ cd vagrant-up-github-pages
$ sed -i 's#XXX#https://github.com/kappataumu/kappataumu.github.com.git#' bootstrap.sh
$ vagrant up
$ curl http://localhost:4000
```

That's all there is to it.

If you don't have `sed` laying around, you can simply tweak `CLONEREPO` right at the top of `bootstrap.sh`, replacing `XXX` with the URL for the GitHub pages repository that we'll instruct Jekyll to serve locally.
