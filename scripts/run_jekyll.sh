: ${1?"No repo. Set the REPO environment variable and try again!"}
clonerepo=${1}
clonedir="/srv/www/$(basename $clonerepo)"
jekyll=$(which jekyll)
wrapper="${jekyll/bin/wrappers}"
log="/home/vagrant/jekyll.log"

# Now, for the Jekyll part. There are some issues you might hit:
#
# * Due to jekyll/jekyll#3030 we need to detach Jekyll from the shell manually,
#   if we want --watch to work.
#
# * We need Vagrant >= 1.8 to fix a regression that botched emission of the
#   vagrant-mounted upstart event, see mitchellh/vagrant#6074 for details.
#
# * We need Ruby 2.1.7p400 due to what appears to be a regression in Ruby's
#   FileUtils core module, see http://stackoverflow.com/q/33091988

echo "Monitoring $clonedir -- Jekyll is accessible over http://localhost:4000"
run="start-stop-daemon --start --chuid vagrant:vagrant --exec $wrapper -- serve --host 0.0.0.0 --source $clonedir --destination /home/vagrant/_site --watch --force_polling >> $log 2>&1 &"
eval $run
