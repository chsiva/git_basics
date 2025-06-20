GitHub upgrades - To ensure you benefit from latest security patches, features, and bug fixes while minimizing  the potential disruption of larger version jumps.


# avoid merge conflicts


https://geshan.com.np/blog/2016/04/3-simple-rules-for-less-or-no-git-conflicts/

# git ( initialing git repo and adding or creating files inside git repo
git init
git add <filename>
  
# check below link for basic git commands with usage
  
https://confluence.atlassian.com/bitbucketserver/basic-git-commands-776639767.html

# git pull
git pull will changes that are done in remote/central repo

# git fetch
git fetch will retrieve the latest meta-data info from the original. It's more like just checking to see if there are any changes available)

# git clone 
is how you "get a local copy" of an existing repository "to work on". 
It's usually "only used once for a given repository, unless you want to have multiple working copies of it around".

# git pull (or git fetch + git merge) 
is how you "update that local copy with new commits" from the remote repository. If you are collaborating with others, it is a command that you will run frequently.

# git clone with ssh vs clone with https
with https no need any authentication
with ssh we need authenticate -> generate ssh keys in local -> copy rsa.pub -> paste it in github/settings/ssh-key

# Forking
A fork is a copy of a repository that allows you to freely experiment with changes without affecting the original project.

# git rebase

It's simple. With rebase you say to use another branch as the new base for your work.

If you have, for example, a branch master, you create a branch to implement a new feature, and say you name it cool-feature, of course the master branch is the base for your new feature.

Now at a certain point you want to add the new feature you implemented in the master branch. You could just switch to master and merge the cool-feature branch:

$ git checkout master
$ git merge cool-feature
But this way a new dummy commit is added. If you want to avoid spaghetti-history you can rebase:

$ git checkout cool-feature
$ git rebase master
And then merge it in master:

$ git checkout master
$ git merge cool-feature


# git squash
For example, assume that you have a series of n commits.
By squashing you can make all the n-commits to a single commit.

# SSl Certificate Issue
https://stackoverflow.com/questions/11621768/how-can-i-make-git-accept-a-self-signed-certificate

# Avoid "merge conflicts" https://dev.to/samuyi/how-to-avoid-merge-conflicts-3j8d
Solution:

*create a new branch* -> in local CLI create a repo and clone the repo here -> git checkout <new-branch> ->
download & install "Meld" (file comparision tool) https://meldmerge.org/. ->

*do merge locally* -> *create new PR*

# clone specific branch 
git clone -b <branch-name> <remote_repo_url>


