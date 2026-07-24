# Open OnDemand Tutorial

## Table of Contents

Live tutorial steps we took during PEARC. See the PEARC video recording to follow along (with images and explanations!):

- [Getting Started](#getting-started)
- [Walkthrough tutorial](#walkthrough-tutorial)
- [Dashboard developer mode tutorial](#dashboard-developer-mode-tutorial)
- [Interactive App Development and Open OnDemand Features](#interactive-app-development-and-open-ondemand-features)
- [Jupyter App Development Tutorial](#jupyter-app-development-tutorial)
- [Dynamic Batch Connect Fields](#dynamic-batch-connect-fields)
- [Passenger App Tutorial](#passenger-app-tutorial)
- [XDMoD Integration Tutorial](#xdmod-integration-tutorial)

These tutorial will be using the `dockerfile.demo` provided in the fronted Open OnDemand repo.

## External links

- [Online Documentation](https://osc.github.io/ood-documentation/master/)
- [Jupyter Install Tutorial](https://osc.github.io/ood-documentation/master/app-development/tutorials-interactive-apps/add-jupyter.html)

## Getting Started

### Login

Now you should login to Open OnDemand through http://localhost:8080.

Login as `jesse@localhost` with the password `owens`. If you ever see a
"Bad Request" page after logging in, clear your cookies for `localhost` (or
use a private/incognito window) and log in again — old cookies from a
previous run of the container are the cause.

### Get a shell session

At some points during this tutorial you'll need to execute commands in a shell session.
You can [use the shell app](http://localhost:8080/pun/sys/shell/ssh/ood.demo)
to get an ssh session in the web browser for this purpose.

## Walkthrough Tutorial

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

This tutorial walks through common features in Open OnDemand. There's no development
involved. It simply walks through features as a user would interact with them to demonstrate
what OnDemand can do.

- [The dashboard landing page](#the-dashboard-landing-page)
- [File management](#file-management)
- [File viewing and editing](#file-viewing-and-editing)
- [The Job Composer](#the-job-composer)
- [Active Jobs](#active-jobs)
- [Interactive Apps](#interactive-apps)
- [Profiles](#profiles)

### The dashboard landing page

The dashboard landing page is the first page users see.  Administrators can
customize what panels are displayed here as well as their position.  Administrators
can choose from predefined panels like the 'Message of the Day' and even create their
own.

The panel welcoming you to this tutorial is a custom panel.

There is a panel with your recently used applications that may show up depending on if
you've run any apps. Once you have started either the desktop or jupyter applications,
you'll see buttons here to relaunch those applications.

The 'Message of the Day' can display your message of the day similar to how shell
logins work. OnDemand supports many formats, and the one shown is in markdown.

Lastly you'll see panels for [XDMoD](../xdmod/README.md). OnDemand integrates
with XDMoD to show pertinant information about the jobs you've recently ran.

![landing page demo](imgs/landing_page_demo.gif)

### File management

In the navigation bar you'll see a dropdown menu entitled `Files`. The first
menu item is your `$HOME` and this comes by default with every installation.
The second menu item has been added as a 'favorite path'.  Administrators
can add many favorite paths to scratch or project spaces for example.

Click the link to `HOME` and you'll be redirected to the file manager.

Here you'll see all the files & directories in your `$HOME` directory.
You'll see several buttons for file management like making new files and directories, 
deleting, downloading, and more.

Go ahead and:
* Make a new directory (you can call it `demo_dir` if you don't have a name handy).
* Add a file to that directory (you can call it `demo_file.txt` if you don't have a name
  handy).
* Download that file.
* Delete that file.
* Open a terminal to this new directory (use the 'open in terminal button').
  You'll see that instead of starting in your `$HOME` directory, you're in this
  new directory that you've created.

Now that you know how to create files, go ahead and create a file and in the next
section we'll edit it.

![file manager demo](imgs/file_manager_demo.gif)

### File viewing and editing

If you haven't already created a new file to edit, please do so now. It doesn't
really matter _where_ this file is. 

Once you have a file you want to edit, click the drop down menu in the same
row as the file and you should see an option to `Edit`.

Press `Edit` in this menu and the file editor will open in a new tab.
In this view, you can edit the file in the web browser!  Go ahead and
do that now, add something to this file. A simple `hello world!` will
suffice. Once you've added something to the file, click the `Save` button
in the top left.

Now that you've edited the file navigate back to the file browser where
this file exists.  Click the same drop down menu you clicked to edit the file
but instead press `View`.  This will open a new tab with a read only copy
of the file you just edited.

![editing file demo](imgs/file_editing_demo.gif)

### The Job Composer

The job composer let's users create and schedule batch jobs from templates.

To navigate there press the `Jobs` menu button from the top level navigation
bar. Press the `Job Composer` link in that dropdown menu and you'll be redirected
to the job composer.

There's a so called `joy ride` that describes what all the buttons do.  You can
click `Next` to go through them all or dismiss it.

To create a job from a template click the `New Job` button at the top left.
Next, select `From Template`. This will fill the table with all the available
templates on the system. Only one has been provided in this tutorial, but
administrators at actual sites can supply as many as they wish.

Press the `Create new job` button in panel on the right side of the screen titled
`Create New "Basic Python Serial Job"`.  Once selected, you've created your own
job from this template. You'll see it's placed in the 
`/home/jesse/ondemand/data/sys/myjobs/projects/default/1`
directory and you can open this directory with buttons on the bottom of the page.

Click the job's row in table in the center of the screen. When this job's row
is highlighted the button to `Submit` the job becomes available. Press the submit
button and you'll submit this job.

The job should succesfully submit and you should see the state badge in the `Status`
column of the central table go from queued to running to completed.

Let's go ahead and edit the script we submit by pressing the `Open Editor` button
at the bottom of the script's panel (you likely have to scroll down).

Add this `sleep 1000` anywhere in the file (so long as it's not commented).

```bash
sleep 1000
```

Submit this job again and next we'll see another view where you can see
your active jobs.

![job composer demo](imgs/job_composer_demo.gif)

### Active jobs

Now that you've got a job running that'll last a little bit from the
previous section, let's navigate to the active jobs page to view it.

Navigate back to the main OnDemand page by pressing `OnDemand` at the
top left of the navigation bar.

Now that we're back to the main OnDemand page, open the `Jobs` drop down
menu at the top of the navigation bar and press `Active Jobs`.

This will redirect you to our Active Jobs page.  On this page you can
see the details of all the active jobs running on your clusters.  There
aren't many jobs running here because we're looking at the cluster that's
in these containers, but on a real system it would show all the jobs on that
system.

![active jobs demo](imgs/active_jobs_demo.gif)

### Interactive Apps

Interactive apps are one of the main features of Open OnDemand. They allow
users a click through interface to some of the most popular applications in
HPC.

This tutorial will go over luanching the Jupyter application as well as generic
Linux desktops

The `Interactive Apps` dropdown menu on the top navigation bar lists all the
interactive applications on this system. Other sites can have many more for example
RStudio and MATLAB.

#### Launching a desktop

Open the `Interactive Apps` menu and press the `Desktop` link. This will redirect
you to a form for this application.  This form can allow users to fill out different
settings to submit the job with. For example the `Number of Hours` field will specify
how long the job can run for. Administrators can specify these fields. So for example
a real site may allow desktops with GPUs and a checkbox in the form for the user to
select a GPU.

There's no need to specify the account, so you can leave it blank. Fill out the rest
of the form (noting that there are only 2 nodes in this cluster) and press the `Launch`
button.

You'll be redirected to `My Interactive Sessions` page where you will see a card for this
job. It should start in the queued state and eventually into the running state. When
it's in the running state a button will appear at the bottom of the card with the text
`Launch HPC Desktop`. Press that button when it becomes available to connect to the desktop.

When you press `Launch HPC Desktop` a new tab will open connecting you to the desktop.
Note that this desktop is running in a container on one of the compute nodes in the Slurm
cluster.  You now have a desktop running on your compute cluster!

Open the applications menu and launch a terminal. Once inside the terminal issue the
`glxgears` command and see the GUI for glxgears open up.  Feel free to keep the session
open for a while and play around with the XFCE desktop.

![desktop demo](imgs/desktop_demo.gif)

#### Launching Jupyter

Navigate back to the tab with Open OnDemand and open the `Interactive Apps` menu
again. Now choose Jupyter instead of a desktop.

This will redirect you to a similar form as we saw before, only it's a form for
launching a Jupyter session instead of a desktop.  Choose your settings and launch
by pressing the `Launch` button.

Similar to the desktop launching, this will redirect you to `My Interactive Sessions`
where a new card for this Jupyter application should be.

You'll note on this card though, it has extra information on it. It displays the
choices that you've made in the form, for example how much memory you've requested.
Administrators, when creating applications, can choose to display certain choices
users make in the form in these cards.

Again when the button to `Connect to Jupyter` becomes available don't press it
just yet. Instead you can press the button near the top of the card labeled `Host`.
This is the host that the job is running on. It's likely cpn01 but could also be
cpn02.  Press this button and OnDemand will open a shell session on that compute
node in a new tab.

This allows users to not only run an interactive application they can connect to,
but also shell access to the job as well.

Navigate back to Open OnDemand's `My interactive sessions` page and press the
`Connect to Jupyter` button. This will open a new tab to the Jupyter application
that's running on a compute node in your Slurm cluster!

Connect to the Jupyter session and navigate to the `jupyter_notebook_data` directory.
Open the `GUI-demo.ipynb` and this should open a new tab to this notebook. Run all
the cells in this notebook for a demonstration that this Jupyter does in fact work.

![jupyter demo](imgs/jupyter_demo.gif)

### Profiles

Open OnDemand 3.0 released with support profiles. Profiles are a way to change
the look and feel of an Open OnDemand installation.

Open the `Help` menu on the right hand side of the navigation bar and click
the `Chemistry` profile. This will redirect you back to the starting page
and set the application into this new profile.  You can select `Default`
from the same menu to get back to the original profile.

The first thing you may notice is that the navigation bar has changed.
The main idea with profiles is to construct a view into the OnDemand system
that limits the choices of users, so that they may more easily find the application
they're interested in or so the system can gear itself towards a specific use
case instead of being more general purpose.

We've changed the navigation bar to limit the choices a user can make
within this profile. The desktop application has been removed and only
Jupyter is available.  Also the `Jobs` menu has been removed along with
several other menu items on the right hand side.

The landing page has also changed. Mostly just re-arranged, but it demonstrates
that different profiles can have different landing pages.

Lastly there's a new link entitled `Chemistry Notes`. Press this link
and you'll be redirected to a custom page.  This page is completely defined
by administrators. Administrators supplied every single panel on this page.
The idea here being that administrators can supply content to their own OnDemand
installation, thereby extending it's functionality by also supplying some
documentation.

![profile demo](imgs/profile_demo.gif)

</details>

## Dashboard developer mode Tutorial

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

This tutorial covers:

- [Starting the dashboard in development mode](#starting-the-dashboard-in-development-mode)
- [Changing the color of the navbar](#changing-the-navbar-color)
- [Pinning apps to the dashboard](#pinning-apps)
- [Changing the dashboard layout](#changing-the-dashboard-layout)
- [Add a custom widget to the dashboard](#add-a-custom-widget-to-the-dashboard)

### Starting the dashboard in development mode

First we need to pull the source code from the Github Repository. Let's
[use the shell app](http://localhost:8080/pun/sys/shell/ssh/ood.demo) for this.

Be sure to be on the `ondemand` host because that container has node and ruby on it,
which we need to build the project.

If you are not using the shell app, use `ssh` to connect to the `ondemand` host from the `frontend` host: `ssh ondemand`

Then, do the following:

```text
git clone https://github.com/OSC/ondemand.git ~/ondemand-src-full
mkdir -p ~/ondemand/dev
cd ~/ondemand/dev
ln -s ../../ondemand-src-full/apps/dashboard/ dashboard
cd dashboard
git checkout release_3.0
bin/bundle config --local path vendor/bundle
bin/setup
```

** NOTE: M1 Mac users need to run the following commands BEFORE `bin/setup`:

```
bundle config build.nokogiri --use-system-libraries
bundle config set force_ruby_platform true
bin/setup
```

Once you run `bin/setup` you should see a bunch of output about getting Rugy gems and building
Node.js packages.

If you've successfully setup, then so you should be able to
[navigate to the development version of the dashboard](http://localhost:8080/pun/dev/dashboard)
where you'll have to click the button to 'Initialize App' to move forward.

That's it! At this point you should be viewing the dashboard in the development mode.  This means
that it's _your own version_ of the dashboard. You can modify this as you see fit without having
to escalate privileges (become root) or disrupt other users.

### Changing the navbar color

We'll need to create and edit an environment file for our development dashboard to read.

```text
# /home/jesse/ondemand/dev/dashboard/.env.local

# you can use pretty names like 'blue' or hex codes like '#5576d1' for royal blue
# OOD_BRAND_BG_COLOR='blue'
OOD_BRAND_BG_COLOR='#5576d1'
```

Now you may have to restart the server with the button at the top right to see the
changes take place.

![dashboard navbar button to restart the web server](imgs/restart_web_server.png)

### Pinning Apps

Now we're going to enable a new feature in 2.0 which is pinning app icons to the dashboard.

First we're going to have to reconfigure the `OOD_CONFIG_D_DIRECTORY` environment variable.
It defaults to `/etc/ood/config/ondemand.d`, but since we don't want to privilege escalate,
we're going to make a new directory in our home.

```text
mkdir -p ~/ondemand/config/ondemand.d
touch ~/ondemand/config/ondemand.d/ondemand.yml
```

```text
# /home/jesse/ondemand/dev/dashboard/.env.local

OOD_CONFIG_D_DIRECTORY="/home/jesse/ondemand/config/ondemand.d"
```

Now let's [edit the ondemand.yml](http://localhost:8080/pun/sys/dashboard/files/edit/home/jesse/ondemand/config/ondemand.d/ondemand.yml)
file that we initialized above to add the configuration.

```yaml
# /home/jesse/ondemand/config/ondemand.d/ondemand.yml

pinned_apps:
  - 'sys/*'
```

Restart the dashboard and you should see pinned apps show up.

![dashboard landing page with app icons pinned to it](imgs/pinned_apps.png)

Now let's group them by their `category` by adding this configuration to the same `ondemand.yml` file.

```yaml
# /home/jesse/ondemand/config/ondemand.d/ondemand.yml

pinned_apps:
  - 'sys/*'

pinned_apps_group_by: 'category'
```

Another restart of the webserver will pick up these configurations and you should see pinned apps
are now grouped by the category of the application.

![dashboard landing page with groups of app icons](imgs/grouped_pinned_apps.png)

See [the documentation on pinned apps](https://osc.github.io/ood-documentation/latest/customization.html#pinning-applications-to-the-dashboard)
for more information.

### Changing the dashboard layout

First we're going to enable the message of the day (MOTD)

Let's add these two environment variables to our `~/ondemand/dev/dashboard/.env.local` file.

```text
# /home/jesse/ondemand/dev/dashboard/.env.local

MOTD_PATH=/etc/motd
MOTD_FORMAT=markdown
```

Restart your webserver and you should now see the MOTD to the right of the page.

Now, just to demonstrate this feature, let's move the MOTD to the left of the page with pinned
app icons being on the right.

```yaml
# /home/jesse/ondemand/config/ondemand.d/ondemand.yml

dashboard_layout:
  rows:
    - columns:
        - width: 4
          widgets: [ motd ]
        - width: 8
          widgets: [ pinned_apps ]
```

See the [documentation on customizing the dashboard layout](https://osc.github.io/ood-documentation/latest/customization.html#custom-layouts-in-the-dashboard)
for more information.

### Add a custom widget to the dashboard

Now that we've changed the layout of the dashboard, let's extend this feature to add a brand new widget.

First, we need to reconfigure where widgets are picked up from.  By default they're in `/etc/ood/config/apps/dashboard/views/widgets`,
but because we don't want to become root to do this, we're going to reconfigure this location.

So we're going to add these entries to our local environment file.

```text
# /home/jesse/ondemand/dev/dashboard/.env.local

OOD_LOAD_EXTERNAL_CONFIG=1
OOD_APP_CONFIG_ROOT="/home/jesse/ondemand/config"
```

Next, in a shell, let's initialize some directories and the widget file.

```text
mkdir -p ~/ondemand/config/views/widgets
touch ~/ondemand/config/views/widgets/_hello_world.html
```

Be sure to add the underscore prefix to this filename! This is a Rails convention for partials and not a mistype
it is indeed `_hello_world.html`.

Now, we can use the [file editor to edit our new widget](http://localhost:8080/pun/sys/dashboard/files/edit/home/jesse/ondemand/config/views/widgets/_hello_world.html).  Let's add this very simple div to just thank you for being here. Of course, you can put
any text you like here. Feel free to have fun with it!

```html
<!-- /home/jesse/ondemand/config/views/widgets/_hello_world.html -->
<div class='alert alert-info text-center' style='font-size:2.2rem;'>
    <p>Thank you for attending the PEARC 2022 Open OnDemand Tutorial!</p>
</div>
```

Now that we have the widget, we need to add it to the layout. Let's make a new row for it and push everything
else to the second row.  This new row will have only one twelve width column that has our new `hello_world`
widget.

```yaml
# /home/jesse/ondemand/config/ondemand.d/ondemand.yml

dashboard_layout:
  rows:
    - columns:
        - width: 12
          widgets: [ hello_world ]
    - columns:
        - width: 4
          widgets: [ motd ]
        - width: 8
          widgets: [ pinned_apps ]
```

Now your dashboard should look something like this with a brand new widget we just creating showing up on the
dashboard.

![dashboard landing page with a new custom widget](imgs/dashboard_w_new_widget.png)

</details>


## Interactive App Development and Open OnDemand Features

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

This section covers some of the patterns and objects that Open OnDemand provides developers with for developing 
interactive apps for scientific research.

### The `batch_connect` Convention Overview

Batch connect apps have a specific structure that Open OnDemand expects and will help you the developer making 
your app easier to reason about and faster to develop on.

**Open OnDemand Expected File Structure for Interactive Apps:**
```
my_app/
├── form.yml.erb      ← User-facing form
├── manifest.yml      ← App metadata (Used for dashboard data)
├── connection.yml    ← App server data needed on frontend (logins, hostnames, etc.)
├── submit.yml.erb    ← Job submission params
└── template/
    ├── before.sh.erb  ← Pre-launch setup
    ├── script.sh.erb  ← Main launch script
    └── after.sh.erb   ← Cleanup (Run at the end of the session)
```

**Interactive App File Execution Flow:**
1. `form.yml.erb` — Renders form → user fills it out, admin prepopulates, or content is fetched from cache 
2. `submit.yml.erb` — Generates job submission config
3. `before.sh.erb` — Runs before main script
4. `script.sh.erb` — Launches the application
5. `after.sh.erb` — Cleanup runs when the _session_ ends (_Not_ when the job ends)

- Docs: https://osc.github.io/ood-documentation/latest/how-tos/app-development/interactive.html
- Helpers source: https://github.com/OSC/ondemand/tree/master/apps/dashboard/app/helpers

### The ERB objects

Open OnDemand's backend is Ruby, and it uses Ruby's built-in templating engine, ERB ("Embedded Ruby"). If you've used Jinja or Django templates, the idea is the same: a file with code embedded in it that gets evaluated before the file is used.

Some example files that use ERB end in `*.erb` that you'll see throughout apps you pull from OSC:

- `form.yml.erb`
- `script.sh.erb`
- `submit.yml.erb`

The extension is the only signal ERB needs to uptake the file. It then reads the file, evaluates any 
Ruby it finds between the ERB tags, and hands back the rendered result.

#### The ERB tags:

| Tag | Behavior |
|---|---|
| `<%= expression %>` | Evaluates and **substitutes the result** into the file |
| `<% statement %>` | Evaluates and **outputs nothing** — use for variables, conditionals, loops |
| `<%# comment %>` | Ignored entirely — never appears in the output |
| `<%- statement -%>` | Same as `<% %>`, but **trims surrounding whitespace** for `yaml` |

This is how apps pull data from the backend at render time: query the cluster, look up the user, 
branch on a condition, and drop the answer into the form or job script before it's used.

#### The `context` Object

The `context` object gives you access to every form field the user filled out on the backend using `ERB` in your `*.erb` files.

Every field in your `form:` array becomes a method on `context`. This is a powerful and promoted pattern in Open OnDemand that will save you 
a lot of time in your app development.

Given a `form.yml` like:
```yaml
form:
  - bc_num_hours
  - bc_num_slots
  - bc_account
  - bc_queue
  - version
  - auto_modules_app
```

You can access any of those fields in your `script.sh.erb` by using `ERB` and calling the set attribute on `context`:
```bash
# Access any form field:
<%= context.version %>
<%= context.bc_num_hours %>
<%= context.bc_account %>
<%= context.bc_queue %>

# Use in conditionals:
<%- if context.version == "4.3" -%>
  module load R/4.3
<%- end -%>
```

#### The `session` Object

The `session` object provides runtime information about the current batch connect session.

| Attribute              | What it gives you                              |
|------------------------|------------------------------------------------|
| `session.id`           | Unique session identifier                      |
| `session.job_id`       | The scheduler job ID                           |
| `session.cluster`      | Name of the cluster (matches cluster configs)  |
| `session.staged_root`  | Path to the session's staged directory          |
| `session.created_at`   | When the session was created                   |

```bash
# Example: Kubernetes-aware logic
<%- if session.cluster =~ /kubernetes/ -%>
  # K8s-specific setup here
<%- end -%>
```

### Helper Methods: Stop Reinventing the Wheel!

Open OnDemand provides helper methods that we see users reinvent all the time. **Use these instead!**

#### `find_port`

Finds an available port on the compute node. No need to hardcode or guess.
```bash
# In script.sh.erb:
port=$(find_port ${host})
export port
```

#### `create_passwd`

Generates a secure random password of the given length. Great for app auth.
```bash
# In script.sh.erb:
password="$(create_passwd 16)"
export RSTUDIO_PASSWORD="${password}"
```

### Common Useful Patterns

#### `connection.yml` entry

Suppose we have an app that wants to use its own auth mechanism.  would 
not be aware of this password which gets generated and it could create a 
complex work around in order to retrieve this data to share with Open OnDemand.

Well Open OnDemand has a pattern for this! We use the `connection.yml` and the 
`conn_params` in the `submit.yml.erb` file in conjunction with the app's 
`view.html.erb` file to generate this data, plug it in for the user, and never 
expose the credentials or involve sharing of those credentials.

We will use RStudio to show this pattern off, and to notice that this app 
needs a `csrf` token to launch, another quirk you may find in apps that 
we can handle with this pattern.

How this works is we use the `before.sh.erb` script to generate this needed 
`password` and `csrf_token` for our app:
```bash
# rstudio 1.4+ needs a csrf token
csrf_token=<%= SecureRandom.uuid %>
# Define a password and export it for RStudio authentication
password="$(create_passwd 16)"

export RSTUDIO_PASSWORD="${password}"
```
Note that we used a lowercase variable for `password` here, this is a 
necessary convention that you _must_ follow for this pattern to work.

Next, we need to ensure we have the `csrf_token` for our app when it is 
submitted to the cluster using the `submit.yml.erb` like so:
```yaml
---
batch_connect:
  template: "basic"
  conn_params:
    - csrf_token
...
```
This is awesome! We've generated the token and shared it with our job as it 
is spun up.

Now, let's combine all this together in the `view.html.erb` to see how we then 
put all this data into our app's session card when it's ready:
```html
<script type="text/javascript">
(function () {
  let date = new Date();
  date.setTime(date.getTime() + (7*24*60*60*1000));
  let expires = "expires=" + date.toUTCString();
  let cookiePath = "path=/rnode/" + "<%= host.to_s %>" + "/" + "<%= port.to_s %>/";
  /**
    rstuido wants a cookie called csrf-token - but that's going to change in 2020!
  */
  let cookie = `csrf-token=<%= csrf_token %>;${expires};${cookiePath};SameSite=strict;secure`;
  document.cookie = cookie;
})();
</script>

<form action="/rnode/<%= host %>/<%= port %>/auth-do-sign-in" method="post" target="_blank">
  <input type="hidden" name="csrf-token" value="<%= csrf_token %>"/>
  <input type="hidden" name="username" value="<%= ENV["USER"] %>">
  <input type="hidden" name="password" value="<%= password %>">
  <input type="hidden" name="staySignedIn" value="1">
  <input type="hidden" name="appUri" value="">
  <button class="btn btn-primary" type="submit">
    <i class="fa fa-registered"></i> Connect to RStudio Server
  </button>
</form>
```
This provides and hides a few pieces of data for the user to connect:
- the `csrf` token: `<input type="hidden" name="csrf-token" value="<%= csrf_token %>"/>`
- the `password` we made: `<input type="hidden" name="password" value="<%= password %>">`
- the username needed: `<input type="hidden" name="username" value="<%= ENV["USER"] %>">`

You can see from this that all the work of usernames, passwords, and other data can all 
be handled from Open OnDemand and shared between the app's files in a way to make the 
user's experience seamless and free of login pop-ups. 

#### Kubernetes-Aware Branching

A very common pattern you'll see in apps that need to support both traditional HPC schedulers and Kubernetes:
```bash
<%- if context.cluster =~ /kubernetes/ -%>
  source /bin/find_host_port       # K8s port assignment
  source /bin/save_passwd_as_secret # Store password securely
  host="$HOST_CFG"
  port="$PORT_CFG"
<%- else -%>
  port=$(find_port ${host})         # Traditional HPC
  password="$(create_passwd 16)"    # Generate password
<%- end -%>
```

#### Dynamic Forms with `form.yml.erb`

You can use `ERB` in your form definition to dynamically populate dropdowns from the filesystem:
```yaml
# form.yml.erb — use ERB to make forms dynamic!
attributes:
  version:
    widget: select
    options:
      <%- Dir.glob('/software/R/*/').each do |d| -%>
      - ["<%= File.basename(d) %>", "<%= File.basename(d) %>"]
      <%- end -%>
```

#### Putting It All Together: `before.sh.erb` and the `script.sh.erb`

Here's a complete example showing `context`, `find_port`, and `create_passwd` working together using the 
`before.sh.erb` script and the `script.sh.erb`.

We need to generate our data for the script before it runs using the `before.sh.erb` pattern that Open OnDemand provides:
```bash
# Set up networking — use Open OnDemand's helpers!
export host=$(hostname)
export port=$(find_port ${host})

# Generate secure auth
export password="$(create_passwd 16)"
export RSTUDIO_PASSWORD="${password}"

```
Now we can use these variables we've set in our `script.sh.erb` like below:

```bash
#!/usr/bin/env bash

# Load modules based on user's form selection (context)
module load rstudio/<%= context.version %>

# Write connection info for Open OnDemand to read
echo "Starting RStudio on ${host}:${port}"

# Launch the application
rserver --www-port ${port} \
        --auth-none 0 \
        --auth-pam-helper-path /usr/lib/rstudio-server/bin/pam-helper \
        --server-data-dir /tmp/rstudio-data
```

These patterns are incredibly useful for any scientific app that needs to share data between the backend and 
the session card. And as we saw in the `connection.yml` pattern above, we can take this further by passing the 
data through to the `view.html.erb` giving users a seamless login experience, like never seeing a password prompt 
for example.

</details>

## Jupyter App development tutorial

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

This tutorial covers:

- [Initializing the developer application.](#create-the-jupyter-application)
- [Debugging the app and getting it to run correctly.](#get-jupyter-working)
- [Changing the type of a form option.](#change-bc_queue-to-a-select-field)
- [Adding limits for form options.](#limit-bc_num_slots)
- [Adding new form options.](#adding-a-jupyterlab-checkbox)
- [Using native scheduler arguements](#using-script-native-attributes)
- [Explanations of the form.yml file.](#a-closer-look-at-the-formyml)
- [Editing the manifest.yml](#edit-the-manifest).
- [Promoting the application to production.](#deploying-to-production)

### Create the jupyter application

Click on "My Sandbox Apps (Development)" from the dropdown menu "Develop" in the navigation bar
to navigate to the sandbox app workspace.

Now create a new app from the button labeled "New App".

This will bring you to a page where you'll click "Clone Existing App" which will bring you to
this form to fill out.  

Fill in `jupyter` as the directory name. `/var/git/bc_example_jupyter` as the Git Remote and
check "Create a new Git Project from this?".  Then click "Submit" to create a new development
application.

This copied what was in `/var/git/bc_example_jupyter` to `/home/jesse/ondemand/dev/jupyter`.
You can navigate to these files [through the Files app with this link](http://localhost:8080/pun/sys/files/fs/home/jesse/ondemand/dev/jupyter/)
or simply Press the "Files" button in Jupyter's row of the sandbox applications table.

![create sandbox app](imgs/create_sandbox_app.gif)

You'll also need to setup `git` for the jesse user at this point, so let's go ahead and do that
and make first commit to the jupyter app as the starting point.

```shell
git config --global user.email jesse@localhost
git config --global user.name "Jesse Owens"
cd ~/ondemand/dev/jupyter
git add .
git commit -m 'starting point'
```

### Get Jupyter Working

#### Configure the correct cluster

The example application we've created does not use the correct cluster configuration, so we've got
to modify it.

If you try to submit it as is, you'll get this error:

![error message that reads The cluster was never set. Either set it in form.yml.erb with `cluster` or `form.cluster` or set `cluster` in submit.yml.erb.](imgs/no_cluster.png)

We need to edit the `form.yml` in the appication's folder. We can navigate to the folder through the
files app.  The URL is `http://localhost:8080/pun/sys/files/fs/home/jesse/ondemand/dev/jupyter/`.

Here you'll see the `form.yml` file. We can edit it by clicking on the file and pressing the "Edit"
button.  This will take us to the [file editor app, with this file open](http://localhost:8080/pun/sys/file-editor/edit/home/jesse/ondemand/dev/jupyter/form.yml)

In the file Editor, specify `localhost` as the cluster attribute near the top of the file like
so: `cluster: "localhost"`. This matches the cluster configured in this container at
`/etc/ood/config/clusters.d/localhost.yml`. Save this file by clicking the "Save" button at
the top left.

#### Launch the Jupyter Application

Now when we navigate back to our [interactive sessions](http://localhost:8080/pun/sys/dashboard/batch_connect/sessions),
you'll see the "Interactive Apps \[Sandbox\]" menu with an item labeled "Jupyter Notebook".

[Follow this link](http://localhost:8080/pun/sys/dashboard/batch_connect/dev/jupyter/session_contexts/new) and we'll be
presented with this form for specifying different attributes about the job we want to launch.

We don't need to change anything in this form, so simply press "Launch" at the bottom of the form. After pressing
launch the job should have successfully launched the job and redirected us back
the [interactive sessions](http://localhost:8080/pun/sys/dashboard/batch_connect/sessions) page where we'll
see a panel showing our job.  

![fix cluster and submit](imgs/fix_cluster.gif)

#### Debug the failure with the Application Logs
 
This job is going to run and fail during startup. But don't worry — this is
the normal development loop, and the app's own logs tell us exactly what went
wrong.
 
When the job completes, the session panel remains, and it links to the job's
working directory. Follow that link and open `output.log` with the "View"
button.

> **Application logs are your primary debugging tool.** `output.log` is the
> output from the command that actually ran on the compute node — the full
> command OnDemand composed from your form inputs and template scripts. That
> means you're seeing exactly what the shell saw when it ran your app, and
> exactly why any failure occurred.
>
> Expect to spend time in these logs whenever you develop an app. Getting an
> interactive app "just right" for your system is usually a loop of: launch,
> read `output.log`, adjust a template or form file, launch again. Learning to
> read these logs *is* learning to develop OnDemand apps.

When you open the log file, you'll see something like this where it says **jupyter: command not found**.
So you can see, we have `PATH` issues.

(You may also see a few `module: command not found` lines above it — this container has no
module system, so the example app's `module load` lines fail harmlessly. We'll remove those
later when we clean up the app. The fatal error is the `jupyter` one.)

```shell
TIMING - Starting jupyter at: Fri Jul 17 18:06:34 UTC 2020
+ jupyter notebook --config=/home/jesse/ondemand/data/sys/dashboard/batch_connect/dev/jupyter/output/e16b9a77-1a4f-4c9e-95f3-d3c23e5e8d76/config.py
/home/jesse/ondemand/data/sys/dashboard/batch_connect/dev/jupyter/output/e16b9a77-1a4f-4c9e-95f3-d3c23e5e8d76/script.sh: line 27: jupyter: command not found
Timed out waiting for Jupyter Notebook server to open port 16970!
```

#### Configure jupyter PATH

So we know what the issue is, the job's script can't find the `jupyter` executable in the `PATH`.

Jupyter was installed in this container with `pip` into `/usr/local/bin`, and the
non-interactive shell that runs your job script doesn't have `/usr/local/bin` on its `PATH`.

We need to add this line to our job's shell script to fix that.

```shell
export PATH="$PATH:/usr/local/bin"
```

So let's [open the template/script.sh.erb in the file editor](http://localhost:8080/pun/sys/file-editor/edit/home/jesse/ondemand/dev/jupyter/template/script.sh.erb)
and add this just before we start jupyter (right after the second "Benchmark info" echo).

The end of `template/script.sh.erb` should now look like this.

```shell
# Benchmark info
echo "TIMING - Starting jupyter at: $(date)"

export PATH="$PATH:/usr/local/bin"

# Launch the Jupyter Notebook Server
set -x
jupyter notebook --config="${CONFIG_FILE}" <%= context.extra_jupyter_args %>
```

#### Correctly launch

Now we can [launch the application again](http://localhost:8080/pun/sys/dashboard/batch_connect/dev/jupyter/session_contexts/new) and it should work.

When it is up and running and available to use the panel will show a "Connect to Jupyter" button.  Click this button
and OnDemand will redirect us to Jupyter.  

![fix path and launch](imgs/fix_path_and_launch.gif)

Congratulations! We've now started development on the Jupyter Notebook batch connect application and
successfully connected to it.

You may want to delete this job now by using the "Delete" button on the panels as we'll be iterating through
developing the application and starting new jobs.

#### Save your spot

Now it's probably a good idea to save the modifications. They're small, but it'll still help if you
ever get into trouble and need to revert. A simplified version of the `form.yml` is in the very next
section, and you may want to use and save _it_ instead so that any `git diff` you do will be much
smaller and easier to read.

You can use the
[shell app to login to this directory](http://localhost:8080/pun/sys/shell/ssh/ood.demo/home/jesse/ondemand/dev/jupyter/)

In this shell you'll save in git with these commands:

```shell
git add .
git commit -m 'initial commit that correctly submits to the localhost cluster'
```

![git save initial](imgs/git_save_initial.gif)

### A closer look at the form.yml

The items in the form.yml directly create what's shown to the users in the form they interact with.
Let's take a closer look at the `form.yml` that created the form you just submitted to get an
understanding of how they relate to what's shown in the UI.

This is the `form.yml` you should have at this point without all the comments.

```yaml
cluster: "localhost"
attributes:
  modules: "python"
  extra_jupyter_args: ""
form:
  - modules
  - extra_jupyter_args
  - bc_account
  - bc_queue
  - bc_num_hours
  - bc_num_slots
  - bc_email_on_started
```

All fields pre-pended with `bc_` are special fields OnDemand provides for convenience. They are commonly
used fields that create corresponding script attribute.  We'll talk more about script attributes later.

* `modules` Specifies the modules loaded. Since it's hard coded to "python" (in the attributes) 
    we didn't see it in the form.
* `extra_jupyter_args` Specifies the extra jupyter arguments but since it's hard coded to "" we didn't
    didn't see it in the form.
* `bc_account` Creates the "Account" text field and submits the job with the given account.
* `bc_queue` Creates the "Partition" text field and submits the job to the given partition.
* `bc_num_hours` Creates the "Number of hours" integer field and submits the job with the given
    walltime.
* `bc_num_slots` Creates the "Number of nodes" integer field and submits the job with the requested
    cores.
* `bc_email_on_started` Creates the "I would like to receive an email when the session starts" checkbox
    and submits the job with a request to email when the job starts.

### Updating the Jupyter App

#### Change bc_queue to a select field
 
On a real cluster, users pick from your scheduler's queues (SLURM calls
them "partitions"). We started with `bc_queue`, a free-text field — but
users shouldn't have to guess valid partition names. A select dropdown is
much friendlier.

A note about this demo environment: this container's cluster is a simple
`localhost` adapter — there's no real scheduler behind it, so it accepts
and ignores queue choices. We'll build the field exactly as you would for
a real SLURM site, because the form and templating mechanics are
identical — that's the part you'll take home.
 
So let's replace `bc_queue` in the form with a new field we'll call
`custom_queue`. Two things to know about how form fields work:
 
* Adding a name to the `form:` section puts a field on the form. By default
  it's a text field, and its label is just a prettified version of its name
  (`custom_queue` would render as "Custom Queue").
* To make a field anything other than a default text field — a different
  widget, a different label — you configure it in the `attributes:` section.
We want a select widget labeled "Partition" (the SLURM term), with two
options. In each option pair, the first element is what the user sees, and
the second is the value actually submitted:
 
```yaml
# form.yml, with only this addition for brevity
attributes:
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - ["Compute", "compute"]
      - ["Debug", "debug"]
form:
  - custom_queue
#   - bc_queue
```
 
Refresh the [new session form](http://localhost:8080/pun/sys/dashboard/batch_connect/dev/jupyter/session_contexts/new)
and you should see the dropdown.
 
But the form only *collects* the value, nothing uses it yet. To use the attributes, we need to adjust the `submit.yml.erb`.

#### Using form attributes in the submit.yml.erb

We'll need to reconfigure the `submit.yml.erb` to use this
new field.  You can
[edit the submit.yml.erb in the file editor app](http://localhost:8080/pun/sys/file-editor/edit/home/jesse/ondemand/dev/jupyter/submit.yml.erb).

You'll need to specify the script's queue_name as the partition like so. The `script` is the logical
"script" we're submitting to the scheduler.  And the `queue_name` is the field of the script that will
specify the queue. (OnDemand knows how to translate it from queue_name into partition for SLURM).

```yaml
script:
  queue_name: "<%= custom_queue %>"
```

The .erb file extension indicates this is embedded ruby file. This means that Ruby will template this file
and turn it into a yml file that OnDemand will then read.  `<%=` and `%>` are embedded ruby tags to turn the
variable (or expression) into a string. Anything we've defined in the `form.yml` can be used in this ERB file.
In this example we just defined `custom_queue` in the form so we can use it directly here.

If you're not super comfortable with the terminology just remember this: `custom_queue` is defined in the `form.yml`
(the file that defines what the UI form looks like) so it can be used in the `submit.yml.erb` (the file
that is used to configure the job that is being submitted) as `<%= custom_queue %>`.

On a real SLURM site you would verify the choice landed by checking the queue,
e.g. `squeue -o "%j %P"`. Our localhost adapter has no queue to inspect — but we
can still prove the plumbing works end to end using the application logs we
learned about earlier. Add this temporary line to the top of your
`template/script.sh.erb`:

```shell
echo "Requested partition: <%= context.custom_queue %>"
```

Now [launch the application again](http://localhost:8080/pun/sys/dashboard/batch_connect/dev/jupyter/session_contexts/new),
open the session's `output.log`, and you'll see your form selection templated
into the running job — the full round trip from form field to ERB to the
compute node. Feel free to remove the echo line afterwards.

![make custom queue](imgs/make_custom_queue.gif)

At this point, this should be the entirety of the `submit.yml.erb` and `form.yml` (without comments).
They're given here in full if you want to copy/paste them. And remember to [save your spot](#save-your-spot)!

```yaml
# submit.yml.erb
script:
  queue_name: "<%= custom_queue %>"
```

```yaml
# form.yml
cluster: "localhost"
attributes:
  modules: "python"
  extra_jupyter_args: ""
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - ["Compute", "compute"]
      - ["Debug", "debug"]
form:
  - modules
  - extra_jupyter_args
  - bc_account
  - custom_queue
  - bc_num_hours
  - bc_num_slots
  - bc_email_on_started
```

#### Limit bc_num_slots

On a real site your cluster has a finite size — if a user requests more nodes
than exist, the job sits in the queue forever. Suppose our cluster had 2 nodes:
we'd want to cap this field so users can't request an impossible job.

So, let's limit this field to a max of 2. (The form enforces this limit in the
UI itself, before anything ever reaches a scheduler.)

```yaml
# form.yml
attributes:
  bc_num_slots:
    max: 2
```

That's it! Again, because `bc_num_slots` is a convenience field, it already has a minimum of 1
that you can't override, because it doesn't make sense to specify 0 or less nodes.

> **`bc_*` fields ship with built-in defaults and limits.** Every predefined
> `bc_*` attribute has sensible values so it behaves correctly with zero
> configuration — you layer your site's constraints (like our `max: 2`) on top.
> The full list of predefined attributes — what widget each creates, which job
> attribute it sets, and its defaults — is in the
> [form.yml reference documentation](https://osc.github.io/ood-documentation/latest/how-tos/app-development/interactive/form.html).
> Before inventing a custom field for your site, check there: if a `bc_*`
> attribute exists for the concept, it already does the scheduler translation
> for you.

#### Using script native attributes

`script.native` attributes are way for us to specify _any_ arguments to the schedulers that
we can't pre-define or have a good generic definition like `queue_name` above.

In this section we're going to put make OnDemand request memory through the sbatch's
`--mem` argument.

First, let's add it to the form like so.

Here are descriptions of all the fields we'll apply to it.  Note if the label was not
not defined the default 'Memory' would have been OK.  Also we don't really need the
the help message here, it was really just for illustration.

* `widget` specifies the type of widget to be a number
* `max` the maximum value, ~1 GB in this case
* `min` the minimum value, 200 MB
* `step` the step size when users increase or decrease the value
* `value` the default value of 600 MB
* `label` the for UIs label
* `help` a help message

```yaml
# form.yml, with only this addition for brevity
attributes:
  memory:
    widget: "number_field"
    max: 1000
    min: 200
    step: 200
    value: 600
    label: "Memory (MB)"
    help: "RSS Memory"
form:
  - memory
```

Again, now to actually use the value we populate in the form, we need to use
it in the `submit.yml.erb`.  This is where `script.native` attributes come in.

```yaml
# submit.yml.erb
script:
  native:
    - "--mem"
    - "<%= memory %>M"
```

This would translate into a command much like: `sbatch --mem 800M`. As you can
see, `native` allows us to pass _anything_ we wish into the scheduler command.

> **`native` is an array of arguments — not a command-line string.** Each flag
> and each value is its own array element, exactly as the scheduler's argv
> would receive them. This trips up nearly everyone once (there's a steady
> stream of Discourse threads to prove it), so to be explicit:
>
> ```yaml
> # CORRECT — flag and value as separate elements
> native:
>   - "--mem"
>   - "800M"
>
> # WRONG — one string; the scheduler is handed the literal
> # argument "--mem 800M" and will reject or misparse it
> native:
>   - "--mem 800M"
> ```
>
> The array form holds for SLURM and most other schedulers. The notable
> exception is HTCondor, whose adapter takes native attributes in a different
> structure — check the adapter documentation if you're targeting it.

As with `queue_name`, our demo's localhost adapter accepts and ignores these —
on your real SLURM site you'd confirm with `squeue -o "%j %m"` and see the
requested memory on the job.

At this point, this should be the entirety of the `submit.yml.erb` and `form.yml` (without comments).
They're given here in full if you want to copy/paste them. And remember to [save your spot](#save-your-spot)!

```yaml
# script.yml.erb
---
script:
  queue_name: "<%= custom_queue %>"
  native:
    - "--mem"
    - "<%= memory %>M"
```

```yaml
# form.yml
cluster: "localhost"
attributes:
  modules: "python"
  extra_jupyter_args: ""
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - ["Compute", "compute"]
      - ["Debug", "debug"]
  bc_num_slots:
    max: 2
  memory:
    widget: "number_field"
    max: 1000
    min: 200
    step: 200
    value: 600
    label: "Memory (MB)"
    help: "RSS Memory"
form:
  - modules
  - extra_jupyter_args
  - bc_account
  - custom_queue
  - bc_num_hours
  - bc_num_slots
  - bc_email_on_started
  - memory
```

#### Adding a jupyterlab checkbox

Jupyter ships with both Notebooks and JupyterLab. Some users may want to
use JuypterLab instead of Notebooks, so let's give them that option.

First, let's add the checkbox to the form.

```yaml
# form.yml, with only this addition for brevity
attributes:
  jupyterlab_switch:
    widget: "check_box"
    label: "Use JupyterLab instead of Jupyter Notebook?"
    help: |
      JupyterLab is the next generation of Jupyter, and is completely compatible with existing Jupyter Notebooks.
form:
  - jupyterlab_switch
```

Refresh the [new session form](http://localhost:8080/pun/sys/dashboard/batch_connect/dev/jupyter/session_contexts/new)
and you should now see your updates.

For this change, there's no need to edit the `submit.yml.erb`.  This toggle happens in the
actual script that's ran during the job, so we have to edit `template.sh.erb`.  Note that
this is also an ERB script, so it gets templated in Ruby before being submitted to the
scheduler.

Line 31 is as follows:

```shell
jupyter notebook --config="${CONFIG_FILE}" <%= context.extra_jupyter_args %>
```

Replace the `notebook` parameter with this new toggle.

```shell
jupyter <%= context.jupyterlab_switch == "1" ? "lab" : "notebook" %> --config="${CONFIG_FILE}" <%= context.extra_jupyter_args %>
```

If you're unfamiliar with Ruby ternary statements, you can read it them like
this: `if true ? do this : else do that`. So this reads, `if context.jupyterlab_switch is 1 use lab, else use notebook`.

Also note the use of `context` here where we didn't have to use that in the `submit.yml.erb`.
This is an important difference.  To reference variables from the form in the `template/*.sh.erb` files
you **must** reference them through the `context` object.

Now you can submit the job with the checked box to use JupyterLab instead of Notebook and you can see
the Jupyter UI is significantly different.

At this point, this should be the entirety of the `form.yml` (without comments).
They're given here in full if you want to copy/paste them. And remember to [save your spot](#save-your-spot)!

```yaml
# form.yml
cluster: "localhost"
attributes:
  modules: "python"
  extra_jupyter_args: ""
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - ["Compute", "compute"]
      - ["Debug", "debug"]
  bc_num_slots:
    max: 2
  memory:
    widget: "number_field"
    max: 1000
    min: 200
    step: 200
    value: 600
    label: "Memory (MB)"
    help: "RSS Memory"
  jupyterlab_switch:
    widget: "check_box"
    label: "Use JupyterLab instead of Jupyter Notebook?"
    help: |
      JupyterLab is the next generation of Jupyter, and is completely compatible with existing Jupyter Notebooks.
form:
  - modules
  - extra_jupyter_args
  - bc_account
  - custom_queue
  - bc_num_hours
  - bc_num_slots
  - bc_email_on_started
  - memory
  - jupyterlab_switch
```

### Promoting to production

#### Cleaning up the form

Now we're ready to deploy to production, let's clean up the form a little bit.

We want to remove some items because they're in the example for a real site, but
for containers, they just don't apply.

Let's remove these items from the form. Note you'll also have to remove `modules` and
`extra_jupyter_args` from the attributes section too.

* `modules` because there is no module system in this container (those were the
    `module: command not found` lines we saw in the log earlier)
* `extra_jupyter_args` because we're not passing any
* `bc_account` because only 1 account is applied to each user, so there's no need to change it.
* `bc_email_on_started` because containers can't email these fake users

Since we got rid of `extra_jupyter_args` and `modules`, we'll also have them remove it from the
`template/script.sh.erb` as well.

Remove lines 13-22 to get rid of modules. And extra_jupyter_args is on line 29 of `template/script.sh.erb`.

```shell
# remove this block from the 'unless' on line 13 to the 'end' at line 22.
<%- unless context.modules.blank? -%>
# Purge the module environment to avoid conflicts
module purge

# Load the require modules
module load <%= context.modules %>

# List loaded modules
module list
<%- end -%>

# ...

# and remove the last parameter given to jupyter on line 31
jupyter <%= context.jupyterlab_switch == "1" ? "lab" : "notebook" %> --config="${CONFIG_FILE}" <%= context.extra_jupyter_args %>
```

Now it should look like this:

```shell
jupyter <%= context.jupyterlab_switch == "1" ? "lab" : "notebook" %> --config="${CONFIG_FILE}"
```

At this point, this should be the entirety of the `template/script.sh.erb` and `form.yml` (without comments).
They're given here in full if you want to copy/paste them. And remember to [save your spot](#save-your-spot)!

```shell
#!/usr/bin/env bash

# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Set working directory to home directory
cd "${HOME}"

#
# Start Jupyter Notebook Server
#

# Benchmark info
echo "TIMING - Starting jupyter at: $(date)"

export PATH="$PATH:/usr/local/bin"

# Launch the Jupyter Notebook Server
set -x
jupyter <%= context.jupyterlab_switch == "1" ? "lab" : "notebook" %> --config="${CONFIG_FILE}"
```

```yaml
# form.yml
cluster: "localhost"
attributes:
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - ["Compute", "compute"]
      - ["Debug", "debug"]
  bc_num_slots:
    max: 2
  memory:
    widget: "number_field"
    max: 1000
    min: 200
    step: 200
    value: 600
    label: "Memory (MB)"
    help: "RSS Memory"
  jupyterlab_switch:
    widget: "check_box"
    label: "Use JupyterLab instead of Jupyter Notebook?"
    help: |
      JupyterLab is the next generation of Jupyter, and is completely compatible with existing Jupyter Notebooks.
form:
  - custom_queue
  - bc_num_hours
  - bc_num_slots
  - memory
  - jupyterlab_switch
```

#### Edit the manifest

The OnDemand UI pulls things from the `manifest.yml` like the title of the application and where to
put it in the column of interactive applications.

Let's change the these fields.  You can change any field except for `role`. And you can change
them to something different than what's given here (have fun with it!). All fields besides `role`
are purely descriptive or relate to UI groups so we can freely change them without any behavior change.
Conversely, `role` _needs_ to be `batch_connect` so don't change this!

```yaml
---
# change the name, this is what shows up in the menu
name: HPC Tutorial Jupyter
# change the category just to differentiate from the system installed
# deskop application
category: Tutorial Apps
# change the subcategory
subcategory: Machine Learning
role: batch_connect
# change the description, this shows up when you hover over the menu item
description: |
  This app will launch a Jupyter Lab or Notebook on one or more nodes.
```

If you want to change `category` and `subcategory` you can freely do so.
These attributes create groupings for applications.  Since we will only have two
applications (the system installed "Interactive Apps/Desktops" and this app)

Now [save your spot](#save-your-spot) because the next thing we're going to do
is deploy this development application to production.

#### Deploying to production

Deploying to production is as easy as copying the files from your dev directory
to the system's app directory: `/var/www/ood/apps/sys/`.

That directory is root-owned (system apps belong to the system), and the `jesse`
user has no sudo in this container — so we'll do the copy from **your host
machine's terminal** (not the shell app) using docker:

```shell
# find your container's ID or name
docker ps

# copy the dev app into the system apps directory (docker exec runs as root)
docker exec <container> cp -R /home/jesse/ondemand/dev/jupyter /var/www/ood/apps/sys/
```

(Substitute `podman` for `docker` if that's your runtime.) On a real site this
step is typically `sudo cp -R jupyter/ /var/www/ood/apps/sys/` performed by an
administrator — root-owned system apps are the normal arrangement.

And that's it! All you have to do now is refresh the page and you should see your
Jupyter system app in the menu along with your sandbox development app.

![deploy to production](imgs/deploy_to_production.gif)

## Dynamic Batch Connect Fields

Dynamic batch connect fields let client-side javascript react to user choices in
the form. Introduced in 2.0 behind the `OOD_BC_DYNAMIC_JS` environment variable,
this feature is enabled by default in modern OnDemand releases — including the
version in this container, so there is nothing to configure.

With this feature - client side javascript can dynamically change the form fields based on user
choices. Sites only have to add more YAML to a `form.yml` to enable this behaviour.  Let's
see some examples.

### Changing min & max values

Let's put some rules around our example `debug` partition. We set a static `min` and `max` of
200 and 1000 respectively on the `memory` field. But in this example, we want different min and
max values when the debug partition is selected. (Like the earlier form exercises, this is pure
form behavior — it works identically here and on your real SLURM site.)

We can configure this behaviour with these `data-min-` and `data-max-` directives attached
to a given option.  When the `debug` queue is choosen we'll automatically set the min and
maximum values of the `memory` field.

Note that we're also setting the `compute` min and maxes again. This is currently the only way
to reset back to defaults if there are any.

```yaml
# form.yml, only showing custom_queue for brevity.
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - [
          "Compute", "compute",
          data-min-memory: 200,         # set the compute queue back to static defaults
          data-max-memory: 1000,
        ]
      - [
          "Debug", "debug",
          data-min-memory: 400,         # change min & max for debug queue
          data-max-memory: 600,
        ]
```

![A gif of a user interacting with the form with the dynamic additons described above. The default queue compute is chosen. The user can range memory form from 200 to 1000. The user chooses the debug queue. The user can now range the memory form item from 400 to 600. Switching back to the compute queue and the user can again range the memory form item from 200 to 1000.](imgs/dynamic_min_max.gif)

### Changing values

Let's take this a little further.  Now, when we choose the `compute` or `debug` partition, let's
automatically set the account we want to use. Note we'll need to add `bc_account` back, as it's what
we'll be setting.

We can add the `data-set` directives on the same `custom_queue` form options.  When users choose the
`debug` queue we'll automatically set the account to `staff`.  When we choose the `compute` queue we
will set the `sfoster` account.

```yaml
# form.yml, only showing custom_queue for brevity.
attributes:
  custom_queue:
    widget: "select"
    label: "Partition"
    options:
      - [
          "Compute", "compute",
          data-min-memory: 200,
          data-max-memory: 1000,

          data-set-bc-account: 'sfoster'    # set the account to sfoster when using compute
        ]
      - [
          "Debug", "debug",
          data-min-memory: 400,
          data-max-memory: 600,

          data-set-bc-account: 'staff'      # set the account to staff when using debug
        ]
form:
  - bc_account
```

(The account names here are just examples — watch the Account field in the form
change as you flip the partition dropdown. On a real SLURM site you'd make sure
the accounts actually exist, e.g. with `sacctmgr add user <user> account=<account>`.)

### Hiding form options

Lastly, we can use this feature to hide and show other form fields. This can be useful when
some options are avaialbe for somethings. For example you may want to show CUDA versions as
a form option for GPU nodes, but not for other nodes.

Add the `data-hide-bc-account` line to our `debug` form option and we'll start hiding that
field when the debug option is chosen.

```yaml
      - [
          "Debug", "debug",
          data-min-memory: 400,
          data-max-memory: 600,

          data-set-bc-account: 'staff',
          data-hide-bc-account: true,       # hide the bc_account field when this is chosen.
        ]
```

</details>

## Passenger app tutorial

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

Access OnDemand dashboard http://localhost:8080

### Ensure environment is configured for development

Configure OnDemand to specify ssh dev host

1. Open Shell app from Sandbox apps
2. Notice the host is the ondemand

Use ondemand SCL

1. `which ruby`. OnDemand uses SoftwareCollections for RHEL7.
2. `scl --list` shows the SCLs. To source the environment, `source scl_source enable ondemand`.
3. For convenience, this was added to `.bash_profile` - `cat ~/.bash_profile`
4. OnDemand configured to ssh to OnDemand host for development `cat /etc/ood/config/apps/dashboard/env`


### Create a simplest app from scratch

Create new app

1. Access OnDemand dashboard http://localhost:8080
2. Develop => My Sandbox Apps to see the list of apps
3. Click Launch Files
4. "New Dir" insert "df" then close
5. Reload My Sandbox Apps

Edit app

1. Click "Details" on df app to open in App Editor
2. Click "Files" button
3. "New File" => config.ru
4. Select and "Edit"
5. Copy app below into editor and click Save:

```ruby
require 'sinatra'

get "/" do
    "<h1>Hello</h1>"
end

run Sinatra::Application
```

Launch app

1. App Editor tab: Click Launch
2. App not initialized; click button to initialize. App displays

Notes:

* You can do the same steps through the shell - we are just editing files and accessing URLs.
* Sinatre gem is included in gem set already available with the ondemand deployment. The ondemand gem rpms are separate rpms with version in the name so they stick around until you remove it - no loss of dependencies due to yum update. See ondemand-gems rpms at https://yum.osc.edu/ondemand/latest/web/el7/x86_64/


### Apps can be written in different languages

Passenger native support for Ruby, NodeJS, Python

Example NodeJS app, create an `app.js` file in the app directory with this content:

```
const http = require('http')

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' })
  res.write('Hello World from Open OnDemand')
  res.end()
})

server.listen(3000, () => {
  console.log('Listening on port :3000')
})
```

Example Python app using system python (v2), create a `passenger_wsgi.py` file in the app directory with this content:

```
import sys

def application(environ, start_response):
    start_response('200 OK', [('Content-type', 'text/plain')])
    return ["Hello World from Open OnDemand (Python WSGI)!\n\n" + sys.version]
```

Can specify a different version of Python/Ruby/Node with wrapper script i.e. `bin/python` and `chmod 755` the file:

```
#!/bin/bash
# if using software collections:
#
#     source scl_source enable rh-python35
#
# then use python instead of python3 below
exec /bin/env python3 "$@"
```

* `chmod 755 bin/python` after creating the file!

Example Python app using python3, create a `passenger_wsgi.py` file in the app directory with this content:

```
import sys

def application(environ, start_response):
    start_response('200 OK', [('Content-type', 'text/plain')])
    return ["Hello World from Open OnDemand (Python WSGI)!\n\n" + sys.version]
```

Notes:

* Passenger detects what app by the presence of a startup file
* restart the PUN if you change the type of app (ruby => python)
* see https://www.phusionpassenger.com/ for Passenger documentation
* https://www.phusionpassenger.com/library/walkthroughs/start/python.html#the-passenger-wsgi-file

### Restarting apps

First go to app editor of df app and launch the app.

Reload via "Restart Web Server"

1. In File editor, insert ``<pre>#{`df`}</pre>`` into response body and save
2. Access app and reload. Changes do not display.
3. In App Editor/Dashboard, click Develop => Restart Web Server
4. Access app and reload

Reload via App Editor

1. In File editor, change title to "df"
2. Access app and reload. Changes do not display.
3. In App Editor click "Restart App". Notice the command it runs
4. Access app and reload

Reload via touch tmp/restart.txt

1. In File editor, change title to "df - disk usage"
2. Access app and reload. Changes do not display.
3. In App Editor click Shell, then exectue command:

       touch tmp/restart.txt

4. Access app URL

Notes:

* restarting only the app is beneficial when using the shell app with development so you don't lose your shell connection
* restarting only the app results in shorter reload time

### Deploy the app

Create manifest

1. In App Editor, click Files.
2. new file: manifest.yml. then select to edit

```
---
name: df
description: disk usage
icon: far://hdd
category: Files
subcategory: Utilities
```

Deploy app

1. In App Editor, click Shell

       cd ..
       sudo cp -r df /var/www/ood/apps/sys/df

2. Reload dashboard/app editor and see app appear in dropdown. Launch it.
3. Initialize app. Notice shell connection lost.



### URIs of apps

Go to Sandbox App tab and notice URL: http://localhost:8080/pun/dev/df
Production app is same URL except "sys" instead of "dev": http://localhost:8080/pun/sys/df

Open new private browser window. Login as sfoster. Try accessing both URLs.

Notes:

* dev apps are only accessible by the user that owns them
* prod apps are accessible to everyone, even if they don't appear in navbar

### App authorization in production

In App Editor, click Shell

    cd /var/www/ood/apps/sys
    sudo chmod 700 df

Notice hpcadmin does not have access

    sudo setfacl -m u:hpcadmin:rx df
    getfacl df

- Now hpcadmin has access
- Now sfoster does not have access

Notes

* authorization controlled through file permissions
* can use ACLs or group ownership

### Status app template

1. My Sandbox Apps. Click New App.
2. Git Remote: `/var/git/ood-example-ps`.
3. Launch

#### Benefits for user

App is branded to look like an OnDemand app

Navbar contains link back to the dashboard.

#### Benefits for developer

You can make some changes without app restart

1. File edit app.rb.
2. Change title.
3. Save & launch or reload app.

There is a unit test. You can change the test first, then change the code to verify.

1. Open shell.
2. Execute `rake`.

Many status apps will do the same thing - get data from a shell command, parse it into an intermediate object, use that to generate a view.

Notes:

* See tutorial for details: https://osc.github.io/ood-documentation/master/app-development/tutorials-passenger-apps/ps-to-quota.html
* As an exercise you could change the app to execute  `df --output=target,pcent | tail -n+2`
* https://github.com/OSC/ood-example-ps



### Apps can use own dependencies

1. Open Shell app to ood-example-ps app
2. `bundle install --path vendor/bundle`
3. `touch tmp/restart`

Notes:

- you can use whatever dependencies you want
- app continues to work even if system libs change
- app specific dependencies adds a "build" step
- takes up more space (but space is cheap)
- very useful during app development to experiment with new packages


### NGINX auto serves assets in public/ directory

1. Open Shell app to df app
2. `mkdir public`
3. `cp /var/www/ood/apps/sys/jupyter/icon.png public/`
4. http://localhost:8080/pun/dev/df3/icon.png

Notes:

- when dealing with links to assets or pages in your app, prefix with app suburi
- app suburi is set in env var `PASSENGER_BASE_URI` set by Passenger

### Manifest category, subcategory and icons

Subcategory specifies section in navbar dropdown

1. Reload shell and `cd /var/www/ood/apps/sys/df`
   `sudo vim manifest.yml` and remove subcategory and save.
2. reload dashboard and see effect.
3. remove category too and save.
4. reload dashboard and see effect.
5. access app and reload.
6. add back category and subcategory and save.

Icon can be an image or a font awesome icon:

1. cp ../jupyter/icon.png .
2. reload dashboard and see effect.
3. rm icon.png.
4. reload dashboard and see effect.

Notes

* app is still accessible even if navbar does not display it

</details>

## XDMoD Integration Tutorial

<details>
  <summary>Click to open or close tutorial details.</summary>

<br>

(Optional) submit a job from job composer to demonstrate XDMoD integration with Job Composer:

1. Jobs => Job Composer
2. Templates
3. Create New Job (with python template)
4. Edit Files
5. Click `jupyter_notebook_data` in tree.
6. Select `plot_rbm_logistic_classification.py` and click Copy
7. Go "back" in browser and click Paste
8. Select script.sh click edit
9. change `hello.py` to `plot_rbm_logistic_classification.py` and save
10. Back to Job Composer and submit job

### Enable the integration

Review integration steps (see dashboard MOTD)

1. run command to update config
2. run command to ingest

Review dashboard widgets - restart Web Server to see

* job efficiency report is based on both core and memory usage but these containers don't gather all the necessary information, which is why they display 100%

Review Job Composer links - access Job Composer

</details>

## Tutorial Navigation
[Next Step - Open XDMoD](../xdmod/README.md)  
[Previous Step - ColdFront](../coldfront/README.md)  
[Back to Start](../README.md)  
