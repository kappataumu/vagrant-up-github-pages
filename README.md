This is a Vagrant configuration plus provisioning shell script that lets you easily `vagrant up` a local Jekyll-powered GitHub pages server. It accompanies my blog post: [Vagrant, Jekyll and Github Pages for streamlined content creation](/articles/vagrant-jekyll-github-pages-streamlined-content-creation.html)

Getting started is straightforward:

```
$ git clone https://github.com/kappataumu/vagrant-up-github-pages.git
$ cd vagrant-up-github-pages
$ vagrant up
$ curl http://localhost:4000
```

Replace `CLONEREPO` in `bootstrap.sh` with the GitHub pages repository you want Jekyll to serve.
