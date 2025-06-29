# Git version & disk
    3.7.19 (8.4 gb) > 3.11.13 (9.8 gb)
    hostnamectl > linux (os type and version)
    Github servers are cluster ( mutliple nodes - have moth primary and secondary) ?
    server disk size >  Dev ( 300 G ) ||  Prod (3 TB)

# Git operations
    git clone <repo-url>
    git checkout -b <branch-name> 
    git branch
    git status
    git add .
    git commit -m "addeded new files/data"
    git push origin master
    
# Git certificate Management
     Go to venafi
     get .pfx file
     download
     upload ( winscp) to git server
     use open ssl command to create pem key
     once pem key > login to git siteadmin > management console > Authentication > upload pemkey
     Note:  pfx is a secure pkcs#12 file with password protected - commonly used for securely export and import privare keys


# GitHub upgrades
    To ensure you benefit from latest security patches, features, 
       and bug fixes while minimizing the potential disruption of larger version jumps.

    what actions when we upgarde Git servers
    Most helpful actions include : 
    Backup craetion > testing lower environment > following recommended upgrade Path > utilizing maintenance mode during the upgrade > carefully managing backups> rollback plan in         case of any issues > essentially planning and controlled process to minimize downtime and potential disruptions to user

    Actions to perform before change implement to save time and maintian communication with users/teams

     - sanapshot/backup request
     - check diskspace is > 15% # $df -h ()
     - download package from nexus # curl -L -O <packege> [ size of pkg ranges from 7 -10 GB ]
     - Inform users via communication channel on GitHub channel
  
    Actions to perform to implement upgrade

     - Take snapshot/backup
     - enable maintainence mode # ghe-cluster-maintanence -s
     - check cluster status ghe-cluster-staus 
     - stop replica mode ( cluster - multi nodes) # ghe-replica-stop
     - upgarde package ghe-upgarde <package-url.pkg
     - upgrade in Dev taken 15 mins & 5 mins to reboot
     - upgrade in Pr5od taken 15 mins & 5 mins to reboot
     - start replica # ghe-replica-start

 
# Avoid merge conflicts

    Each developer should clone repo, before any change to the branch, developer should perform pull operation > Any new changes should be fetched and 
    
    https://geshan.com.np/blog/2016/04/3-simple-rules-for-less-or-no-git-conflicts/

# Git issues during work
    1. SSl Certificate Issue
         https://stackoverflow.com/questions/11621768/how-can-i-make-git-accept-a-self-signed-certificate
         - Recommendeed: get the cert and install # git config --global http.sslCAInfo /path/to/cert.pem.
         - not recommended but to proceed further use command $git -c http.sslVerify=false clone https://example.com/path/to/git

     2. GitHub Api rate limit exceeded
        incrase request submitted  - 5000 per token using below link
        https://docs.github.com/en/enterprise-server@3.17/admin/configuring-settings/configuring-user-applications-for-your-enterprise/configuring-rate-limits
        Created Personal access token > Github developer setting > Clssic token (copied and saved) >Configure sso (allowing token to read repos isndide org via API)
        PAT (token) > Configure on Jenkins ( Manage credential under Global section )

    3. Account suspended
        Cause/Resolution: 
           - not login for more than 90 days  [ site admin >webhooks > user email > unsuspend
           - contractor converted to FTE ( name might contain xt) [ update saml nameID unter under siteadmin/<user-id> ]

    4. unable to clone or  403 unauthorized access or repo access
        - see network credentials stored on windows/Mac
        - clone repo and pass token using httpsurl
        - repo access is controlled via ad groups and user should be member of it
        - Even user is member already but group is not synched with repo or proper permisisons were not setup
            not synched adgroup with repo > Github synching tool to be installed under apps
            once New org created - Team will get notified on Teams channel 
            


            


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



# Branch protection rules

  - File [ Place the CODEOWNERS file in the root, .github/, or docs/ folder.]
    You can use GitHub usernames (@username) or team handles (@org/team-name).
  - Manually [ Open settings on Repo > Branches > Add Branch Protection Rule ]
  

  Combine branch protection rules with CI/CD pipelines to ensure quality.

  Use code owners to automatically request reviews from specific teams.

  Review rules periodically to match team workflow changes.

  
# git rebase

Always be mindful of the "Golden Rule of Rebasing": never rebase commits that have been pushed to a shared repository.

Is this means it is only used for non shared repos
That's a key point to understand, and your phrasing highlights the important distinction between git rebase and git pull (merge) in a collaborative environment. 
git rebase for local cleanup/history rewriting: git rebase is primarily used on branches that haven't been shared yet. This allows you to clean up your local commit history (e.g., squashing small commits into one, reordering commits) before pushing them to a shared repository.
git pull (merge) for shared branch updates: When working on a shared branch (a branch that other developers have access to and are working on), you should use git pull (merge) to incorporate changes from the remote repository. This preserves the history of the shared branch and avoids causing problems for your collaborators. 
Why rebasing shared branches is problematic:
Rewriting history: When you rebase a shared branch, you are effectively creating new commits and overwriting the existing history.
Conflicting histories: If your collaborators have based their work on the original commits, their local histories will diverge from the rebased branch. This can lead to complex merge conflicts and confusion when they try to pull the rebased changes.
Force pushing: You might need to use git push --force to update the remote branch after rebasing. This can overwrite other developers' work, potentially leading to lost changes. 
In essence:
Rebasing is for rewriting history on private or local branches.
Merging is for integrating changes on shared or public branches. 
Exception:
You might rebase a shared branch if everyone on the team is aware of it and understands the potential implications. However, this requires careful coordination and communication among team members. 


# git squash
For example, assume that you have a series of n commits.
By squashing you can make all the n-commits to a single commit.




 





*create a new branch* -> in local CLI create a repo and clone the repo here -> 
git checkout <new-branch> ->

download & install "Meld" (file comparision tool) https://meldmerge.org/. ->

*do merge locally* -> *create new PR*

# clone specific branch 
git clone -b <branch-name> <remote_repo_url>


