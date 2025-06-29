# GitHub Actions: 
    GitHub Actions is a robust continuous integration and continuous delivery (CI/CD) platform natively integrated within GitHub, 
    allowing for automation of the software development lifecycle directly from the repository. 
    Workflows, defined in YAML files, can be triggered by various events like code pushes or pull requests 
    and execute build, test, and deployment jobs on either GitHub-hosted or self-hosted runners. 
    This enables teams to automate critical tasks, streamline workflows, enhance collaboration through immediate feedback, and deploy applications efficiently, all while leveraging a vast marketplace of reusable actions for tasks such as linting, testing, and cloud deployments.

# software development lifecycle (SDLC):
     - Requirements gathering > Development (Design) > Implementation > Testing (QA analysis) > Deployment > Maintenance
     
# continuous integration and continuous delivery (CI/CD):
      - CI: Focuses on getting code integrated and tested frequently to ensure quality and prevent integration issues early on.
      - Continuous Delivery: Ensures that the codebase is always ready to be deployed, 
           but requires a "final manual step" before releasing to production.
      - Continuous Deployment: Automates the entire process, including the release to production, 
           once the code passes all tests. 
     In essence:
     Continuous Delivery: You have the capability to deploy to production at any time, but you choose when to do so manually.
                 Ex: Octoppus Deployand IBM UrbanCode Deploy (Udeploy)
     Continuous Deployment: Every successful code change is automatically deployed to production. 
                 Ex: Jenkins, Git Lab
    

# Workflow vs Job VS Action
     A workflow is the entire process that is automated, triggered by an event. 
    It is composed of jobs, which are sets of steps that perform related tasks. 
    Each step within a job can either run a script or execute an action, 
      which is a reusable unit of code that performs a specific task. 
    (actions are the individual tasks or steps that a workflow performs)
 
### Summary Table (Componnents in Git Actions)

        | Component            | Common Name      | Identifier Example         |
        |---------------------|-------------------|----------------------------|
        | Workflow            | Workflow          | `name: CI/CD Pipeline`     |
        | Event               | Events            | `on: push`                 |
        | Job                 | Job               | `build-job:`               |
        | Step                | Step              | `- name: Checkout code`    |
        | Environment Variable | Environment      | `env: NODE_ENV: production`|
        | Output              | Output            | `outputs: build_number`    |
        | Input               | Input             | `inputs: branch:`          |

       Note: In GitHub Actions, identifiers are the names you use to refer to various components within your workflow.
   

# Identifiers (Names) must follow certain naming conventions:
    - No spaces or special characters (other than dashes and underscores).
    - Must be unique within the same context (e.g., each job name must be unique within a workflow).


# How do you trigger a GitHub Actions workflow?
  On GitHub events like push, pull_request, workflow_dispatch, schedule, release, etc.
  Can specify filters like branches, tags, or paths.
       on:
       push:
       branches:
         - main
       pull_request:
       branches:
         - develop

  | Trigger             | Description                                         | Manual / Auto | Common Use Cases                         | Supports Inputs |
| ------------------- | --------------------------------------------------- | ------------- | ---------------------------------------- | --------------- |
| `push`              | Runs on `git push` to specified branches/tags       | 🚀 Automatic  | Run CI on every code push                | ❌               |
| `pull_request`      | Runs when a PR is opened, synchronized, or reopened | 🚀 Automatic  | Validate PRs before merging              | ❌               |
| `schedule`          | Runs on a cron schedule (UTC time)                  | 🕒 Automatic  | Nightly builds, dependency updates       | ❌               |
| `workflow_dispatch` | Runs only when manually triggered via GitHub UI/API | ✅ Manual      | On-demand tests, deployments, patch jobs | ✅ Yes           |


# What runners are available in GitHub Actions?
  - GitHub-hosted runners: Provided by GitHub, pre-configured VM images (Linux, Windows, macOS).
  - Self-hosted runners: Your own machines/servers you configure to run workflows.


# How do you pass secrets and environment variables in GitHub Actions?
    - Use GitHub Secrets to store sensitive data securely.
    - Access secrets in workflow via ${{ secrets.SECRET_NAME }}.
    - Can also set environment variables at workflow, job, or step level.


*** On Repo settings > secrets and variables > Actions > secrets ***
    
    - name: set wif values based on environemnt
      run: |
        if [[ "${{ github.event.inputs.environment }}" == "dev" ]]; then
          echo "WIF_PROVIDER=${{ secrets.WIF_PROVIDER_DEV }} >> $GITHUB_ENV
          echo "WIF_service_account=${{ secrets.WIF_service_account }} >> $GITHUB_ENV
        elif [[ "${{ github.event.inputs.environment }}" == "qa" ]]; then
          echo "WIF_PROVIDER=${{ secrets.WIF_PROVIDER_DEV }} >> $GITHUB_ENV
          echo "WIF_service_account=${{ secrets.WIF_service_account }} >> $GITHUB_ENV
        elif [[ "${{ github.event.inputs.environment }}" == "prod" ]]; then
          echo "WIF_PROVIDER=${{ secrets.WIF_PROVIDER_DEV }} >> $GITHUB_ENV
          echo "WIF_service_account=${{ secrets.WIF_service_account }} >> $GITHUB_ENV
        else 
          echo "Invalid environemnt"
          exit 1
        fi

    Note: You can the values now for ex: ${{env.WIF_PROVIDER}} & ${{env.service_account}}
    
          
  
*** Env/Repo variables: On Repo settings > secrets and variables > Actions > Variables ***

     name: Example workflow
     on: [push]
     env:
       GLOBAL_VAR: 'GlobalValue' # Workflow-level variable
     jobs:
       example_job:
         runs-on: ubuntu-latest
         env:
           JOB_VAR: 'JobSpecificValue' # Job-level variable
         steps:
         - name: Use global and job-specific variables
           run: |
              echo "Global variable: $GLOBAL_VAR" # Access global variable

    Note: Repository Variables are Available to all workflows and jobs within that repository.
    Note2: Environment Variabnles ( Dev/QA/Prod) are Limited to the scope (workflow, job, or step) where they are defined.
    
# How can you reuse code or workflows in GitHub Actions?
  1. Reusable Workflow (.github/workflows/reusable.yml)
  2. Use workflow_call event to call reusable workflows
     name: Reusable Workflow  
       on:
         workflow_call:
     jobs:
       call-reusable:
          uses: ./.github/workflows/reusable.yml



| Feature                   | Composite Actions (using: "composite")   | Reusable Workflows (`workflow_call`)     |
| ------------------------- | ---------------------------------------- | ---------------------------------------- |
| Purpose                   | Reuse a sequence of steps in **one job** | Reuse **entire workflows or jobs**       |
| YAML Location             | `.github/actions/my-action/action.yml`   | `.github/workflows/reusable.yml`         |
| Called with               | `uses: ./github/actions/my-action`       | `uses: ./.github/workflows/reusable.yml` |
| Can define multiple jobs? | ❌ No                                     | ✅ Yes                                    |
| Can access secrets?       | ✅ Yes                                    | ✅ Yes                                    |
| Can run scripts?          | ✅ Yes (with `run:`)                      | ✅ Yes                                    |
| Better for...             | Small, repeatable logic in one job       | Higher-level orchestration, full flows   |

composite example 
on: push
jobs:
  example_job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ./.github/actions/my-composite-action
        with:
          input_name: 'World'
        id: my_composite_step
      - name: Use output from composite action
        run: echo "Output from composite action: ${{ steps.my_composite_step.outputs.output_name }}"

# What is the difference between jobs.<job_id>.needs and jobs.<job_id>.strategy.matrix?
  - needs: Defines job dependencies; a job waits for others to finish.
    
            jobs:
              build:
                runs-on: ubuntu-latest
                steps:
                  - name: Build
                    run: echo "Building..."
            
              test:
                runs-on: ubuntu-latest
                needs: build  # This job depends on the 'build' job
                steps:
                  - name: Test
                    run: echo "Testing..."
            
              deploy:
                runs-on: ubuntu-latest
                needs: [build, test]  # This job depends on both 'build' and 'test'
                steps:
                  - name: Deploy
                    run: echo "Deploying..."

    
  - strategy.matrix: Runs the same job with different configurations (e.g., different OS or language versions).

        jobs:
          build-and-test:
            runs-on: ${{ matrix.os }} # Use a matrix variable for the runner OS
            strategy:
              matrix:
                os: [ubuntu-latest, windows-latest, macos-latest] # Test on different OS
                node-version: [14.x, 16.x, 18.x] # Test with different Node.js versions
            steps:
              - name: Checkout code
                uses: actions/checkout@v4
              - name: Set up Node.js ${{ matrix.node-version }} # Access the matrix variable
                uses: actions/setup-node@v4
                with:
                  node-version: ${{ matrix.node-version }}
              - name: Install dependencies
                run: npm install
              - name: Run tests
                run: npm test


# How do you handle failure or retry in GitHub Actions?
  *** Use continue-on-error to ignore step failures (ignore errors) ***
  
      - name: Step that can fail
        id: potentially_failing_step # Give it an ID to reference its status
        run: |
          echo "This step might fail"
          # Simulate a failure
          exit 1
        continue-on-error: true # Allow this step to fail
        
  - Use if conditionals to run steps/jobs conditionally.

        - name: Run this step only if a previous step succeeded
          if: steps.previous_step_id.outcome == 'success' # Check the outcome of a step with the ID 'previous_step_id'
          run: echo "This runs after previous_step_id succeeded"

  - Use jobs.<job_id>.timeout-minutes to limit execution time.

          jobs:
            my-job: # Replace 'my-job' with your job's ID
              runs-on: ubuntu-latest
              timeout-minutes: 30 # Set the timeout to 30 minutes
            steps:
     Note: Currently, no native retry, but you can script retries or use marketplace actions.

# How do you debug failed GitHub Actions runs?

    - Check logs on GitHub Actions UI.
    
    - Use ::debug:: commands in workflow scripts.
       steps:
      - name: Debugging step
        run: |
          echo "This is a normal log message"
          echo "::debug::This is a debug message that will appear when debugging is enabled."
          echo "Another normal message"
          
    - Run workflows locally using tools like act.
    
    - Add verbose logging in your scripts.
        #!/bin/bash
        
        # This command will not be printed
        echo "Starting my script"
        
        # Enable verbose logging
        set -x 
        
        # These commands will be printed before execution
        echo "Executing some commands..."
        ls -l /tmp/my_directory
        pwd
        
        # Disable verbose logging
        set +x
        
        # This command will not be printed
        echo "Script finished"
      

# How do you control access and permissions in GitHub Actions?
   - Use repository and organization level actions policies.
   - Control access to secrets and tokens.
   - Use least privilege principle in workflow permissions.

# Build artifacts In GitHub Actions, 
   artifacts are files or data generated during a workflow run that you can save and share between jobs or download later. They're commonly used to store:

    - Build outputs (e.g., compiled binaries, packages)
    - Test results
    - Log files
    - Coverage reports

    Local storage on runners (Temporary)
      During a job:
      Artifacts are temporarily stored on the runner’s local disk (e.g., /home/runner/work/repo-name/).
      Once the job ends, the runner is destroyed, and the files are lost unless uploaded.

    Yes, you can export or store your GitHub Actions build artifacts for longer periods than the default retention offered by GitHub.
    GitHub Actions provides the actions/upload-artifact and actions/download-artifact actions to manage artifacts. 
    By default, GitHub retains build logs and artifacts for 90 days, and this retention period can be customized. 
    For private repositories, this can be extended up to 400 days. 

    However, if you need to store artifacts for longer durations 
       or require a separate storage solution, here's how you can achieve that: 
       - Artifacts can be exported to S3/GCS buckets.
       - Artifact repository like Jfrog


# Why Use Caching in Workflows?
      Caching reduces:
        - Dependency installation time (e.g., npm install, pip install, maven install)
        - Rebuilding or re-downloading large files
        - CI/CD costs (faster builds = fewer compute minutes)

    GitHub Actions caching can significantly speed up your workflows by reusing files and dependencies between runs. This is particularly useful for things like project dependencies (e.g., node_modules, vendor directories), which can take a long time to download or build. 
        Here's a breakdown of how to use caching in your workflows:
        1. Use the actions/cache action: 
        GitHub provides a dedicated action for caching, called actions/cache.
        You'll add this action to your workflow's steps to set up caching. 
        2. Specify the path to cache: 
        This is the directory or files you want to cache (e.g., node_modules for Node.js projects, vendor for PHP Composer dependencies).
        You can specify a single path or multiple paths on separate lines.
        Glob patterns are supported. 
        3. Define a key for the cache: 
        This key uniquely identifies the cache entry.
        It can be a static string or a dynamic string constructed using expressions.
        To ensure the cache is updated when dependencies change, you can include the hash of your dependency lock file (e.g., package-lock.json, composer.lock) in the key using the hashFiles function.
        Including the runner OS in the key is also a good practice to prevent issues with different operating systems or environments. 
        4. Consider using restore-keys: 
        These are fallback keys that GitHub Actions uses if an exact match isn't found for the primary key.
        They are used to restore from partially matching caches.
        restore-keys can help when restoring caches from other branches because they allow for partial matches. 
        5. Example (Node.js):

        jobs:
          build:
            runs-on: ubuntu-latest
            steps:
            - uses: actions/checkout@v3
            - name: Cache node_modules
              uses: actions/cache@v4 # Use the appropriate version
              with:
                path: node_modules
                key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
                restore-keys: |
                  ${{ runner.os }}-node-
            - name: Install Dependencies
              run: npm install
            # ... other steps ...    


| Feature                       | **GitHub Actions**                            | **GitLab CI/CD**                                                    |
| ----------------------------- | --------------------------------------------- | ------------------------------------------------------------------- |
| **Platform**                  | Part of GitHub                                | Part of GitLab                                                      |
| **CI/CD Integration**         | Built-in automation with `.github/workflows/` | Built-in with `.gitlab-ci.yml`                                      |
| **Pipeline Model**            | Workflow → Job(s) → Step(s)                   | Pipeline → Stage(s) → Job(s)                                        |
| **Triggers**                  | Events (push, PR, schedule, etc.)             | Events (push, merge request, schedule, etc.)                        |
| **Runner Types**              | GitHub-hosted & self-hosted runners           | GitLab-hosted & self-hosted runners                                 |
| **Ease of Use**               | Simple YAML syntax; marketplace actions       | Mature syntax; integrated with GitLab UI                            |
| **Marketplace**               | ✅ 25,000+ reusable Actions available          | ❌ No centralized marketplace (reusable jobs via includes/templates) |
| **Container/Service Support** | Docker support built-in                       | Excellent Docker and Kubernetes support                             |
| **Caching & Artifacts**       | Supported (manual configuration)              | More mature & easier caching/artifact features                      |
| **Monorepo Support**          | Decent (manual workflows)                     | Strong monorepo support (rules, includes)                           |
| **Security Features**         | OIDC, Secrets, Approvals                      | OIDC, Secrets, Protected Envs, Runner isolation                     |
| **Open Source**               | Mostly closed source                          | GitLab CE (Community Edition) is open source                        |
| **Self-hosting**              | Partial (runners only)                        | Full self-hosted GitLab instance possible                           |


my-repo/
└── .github/
    └── workflows/
        ├── test.yml
        ├── deploy.yml
        └── lint.yml

| Limit Type                  | Maximum Allowed             |
| --------------------------- | --------------------------- |
| **Total jobs per workflow** | **256 jobs**                |
| **Total steps per job**     | 2,000 steps                 |
| **Max run time per job**    | 6 hours (depending on plan) |
| **Artifacts per workflow**  | 100 artifacts               |
| **Matrix job combinations** | 256 (max matrix expansion)  |
| **Concurrent jobs**         | Varies by plan (see below)  |


| Concept       | What It Is                                                                                              | Example                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **`jobs`**    | Top-level units of work that run independently or in sequence. Each job runs in a separate environment. | `yaml<br>jobs:<br>  build:<br>    runs-on: ubuntu-latest<br>`                  |
| **`steps`**   | Instructions within a job that run **in order**. Can be shell commands or actions.                      | `yaml<br>steps:<br>  - run: echo "Hello"<br>  - uses: actions/checkout@v4<br>` |
| **`runs-on`** | Specifies the **runner environment** (e.g., Ubuntu, Windows, macOS) for a job.                          | `yaml<br>runs-on: ubuntu-latest<br>`                                           |
| **`uses`**    | Invokes a prebuilt **action** from GitHub Marketplace or a local/custom action.                         | `yaml<br>- uses: actions/checkout@v4<br>`                                      |
| **`env`**     | Sets **environment variables** for jobs or steps. Can be reused in commands.                            | `yaml<br>env:<br>  NODE_ENV: production<br>`                                   |
| **`secrets`** | Secure values (e.g., API keys, tokens) stored in repo or org settings. Accessed using `secrets.*`.      | `yaml<br>env:<br>  API_KEY: ${{ secrets.MY_API_KEY }}<br>`                     |



name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test




# Workflow create
  option: Actions > Create new workflow option > create workflow/simple workflow by GitHub ( your repo)

# Integrate with Terraform

  option1: Actions > Create new workflow option > under deployments category > Terraform

  https://github.com/hashicorp/setup-terraform#

name: Terraform

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2  # it is the action that will get the terraform installed
        with:
          terraform_version: 1.0.0 # Specify the desired Terraform version

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        if: github.event_name == 'pull_request'
        run: terraform plan -out tfplan

      - name: Terraform Apply
        if: github.event_name == 'push' && github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve

  

# Integrate checkmarx/Sonarqube/Veracode

  options: Actions > Create new workflow option > under security category > checkmarx/Sonarqube/Veracode

# Integration workflow with actions from marketplace
  https://github.com/marketplace
