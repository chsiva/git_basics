# Why GitHub upgrades - 
 To ensure you benefit from latest security patches, features, and bug fixes while minimizing  the potential disruption of larger version jumps.

# what actions when we upgarde GitLab servers
  Most helpful actions include : backup craetion > testing lower environment > following recommended upgrade Path > utilizing maintenance mode during the upgrade > carefully managing backups> rollback plan in case of any issues > essentially planning and controlled process to minimize downtime and potential disruptions to user

  Inform users via communication channel on GitHub channel  ( broadcast messages )
  enable maintainence mode > backup> Stop repilica mode > download package and upgrade ( ghe-upgrade)
  ghe-cluster-maintanence -s
  ghe-cluster-staus
  curl -L -O <packege>
  ghe-upgarde <package>

# hostnamectl > linux (os type and version)
# Github servers are cluster ( mutliple nodes - have moth primary and secondary) ?
# server disk size >  Dev ( 300 G ) ||  Prod (3 TB)

 

# avoid merge conflicts

Each developer should clone repo, before any change to the branch, developer should perform pull operation > Any new changes should be fetched and 


https://geshan.com.np/blog/2016/04/3-simple-rules-for-less-or-no-git-conflicts/

# git ( initialing git repo and adding or creating files inside git repo
git init
git add <filename>
  
| Command          | What It Does                                                                | Changes History   | Local/Remote   | When to Use                                         |
| ---------------- | --------------------------------------------------------------------------- | ----------------- | -------------- | --------------------------------------------------- |
| **`git clone`**  | Copies entire remote repo to your machine                                   | No                | Remote → Local | First time you're working with a repository         |
| **`git fetch`**  | Downloads latest changes from remote, but doesn’t merge                     | No                | Remote → Local | To preview or inspect remote updates                |
| **`git pull`**   | Fetches + merges remote branch into current local branch                    | Maybe (merge)     | Remote → Local | To bring in the latest code and automatically merge |
| **`git merge`**  | Combines two branches (adds a merge commit unless it's fast-forward)        | Yes (adds commit) | Local          | To integrate changes from another branch            |
| **`git rebase`** | Moves your branch's commits on top of another base (linear history)         | Yes (rewrites)    | Local          | To clean up history before merging                  |
| **`git squash`** | Combines multiple commits into one (via interactive rebase or squash merge) | Yes (rewrites)    | Local          | To clean "WIP" commits before pushing or merging    |

# use cases

| Situation                                   | Recommended Command      |
| ------------------------------------------- | ------------------------ |
| First-time setup of repo                    | `git clone`              |
| Check what’s new in remote                  | `git fetch`              |
| Sync and merge updates from team            | `git pull`               |
| Merge completed feature into main           | `git merge`              |
| Make feature branch history clean before PR | `git rebase`             |
| Collapse messy local commits into one       | `git rebase -i` (squash) |



You're right, both git pull and git rebase are used to update your local branch with changes from a remote repository. However, the way they achieve this differs and has implications for your commit history. 

Here's the key difference:
 git pull (by default):
   - Fetches and merges: git pull is a combination of two commands: git fetch and git merge.
   - Creates merge commits: By default, it fetches the latest changes from the remote and then merges them into your current branch. This process creates a new "merge commit" to            combine the histories of both branches.
   - Non-linear history: The merge commits result in a non-linear commit history, which shows how branches diverged and converged.
   - Preserves history: This approach preserves the complete history, including all merge commits. 
 git rebase (or git pull --rebase):
   - Rewrites history: git rebase moves or combines a sequence of commits to a new base commit.
   - Applies changes on top: It takes your local commits and reapplies them on top of the latest commit from the target branch (e.g., the remote's main branch).
   - Linear history: This creates a linear history that makes it look like you started your work from the latest version of the target branch.
   - Avoids merge commits: It avoids creating extra merge commits, resulting in a cleaner and simpler commit history. 
 In summary:
  - git pull combines fetch and merge, creating merge commits and a potentially non-linear history.
  - git rebase (or git pull --rebase) rewrites history by applying your commits on top of the target branch, resulting in a linear history without merge commits. 
  - Choosing between git pull and git rebase:


# git clone with ssh vs clone with https
with https no need any authentication
with ssh we need authenticate -> generate ssh keys in local -> copy rsa.pub -> paste it in github/settings/ssh-key

# Forking
A fork is a copy of a repository that allows you to freely experiment with changes without affecting the original project.



#Branch protection rules

  - File [ Place the CODEOWNERS file in the root, .github/, or docs/ folder.]
    You can use GitHub usernames (@username) or team handles (@org/team-name).
  - Manually [ Open settings on Repo > Branches > Add Branch Protection Rule ]
  

  Combine branch protection rules with CI/CD pipelines to ensure quality.

  Use code owners to automatically request reviews from specific teams.

  Review rules periodically to match team workflow changes.
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


