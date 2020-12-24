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

# git squash

# SSl Certificate Issue
https://stackoverflow.com/questions/11621768/how-can-i-make-git-accept-a-self-signed-certificate

# Avoid "merge conflicts" https://dev.to/samuyi/how-to-avoid-merge-conflicts-3j8d
Solution:

*create a new branch* -> in local CLI create a repo and clone the repo here -> git checkout <new-branch> ->
download & install "Meld" (file comparision tool) https://meldmerge.org/. ->

*do merge locally* -> *create new PR*

# clone specific branch 
git clone -b <branch-name> <remote_repo_url>


