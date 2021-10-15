# Start Here

- [Start Here](#start-here)
  - [Introduction](#introduction)
  - [Requirements](#requirements)
  - [Design](#design)
  - [Setup](#setup)
    - [First the shell](#first-the-shell)
    - [Installing the Basics](#installing-the-basics)
    - [Use `conda` to set up a Python (3) interpreter](#use-conda-to-set-up-a-python-3-interpreter)
    - [Some notes about `vscode`](#some-notes-about-vscode)
    - [Some notes about the git repo](#some-notes-about-the-git-repo)
    - [The Sphinx config](#the-sphinx-config)
    - [The Makefile](#the-makefile)
    - [The Document Tree](#the-document-tree)
    - [Configuring `cheat`](#configuring-cheat)
  - [Start It up](#start-it-up)
  - [What Do I Do Now?](#what-do-i-do-now)
  - [The Big Questions](#the-big-questions)

## Introduction

What is this? What is a Second Brain?

For years I have been keeping journals, both for work and personal uses. Usually these manifest as a "digital diary", simply recording thoughts in a file for a given day. This serves as a record of thoughts and events that I might periodically review. For professional use the daily journal records the events of the day, meeting notes, and technical problems and solutions. I often use it with `git grep` to find answers to questions or uses of tools. "I've seen this problem before. What did I do to solve it?"

For at least the last year or two, my journals have been written in [reStructuredText](https://docutils.sourceforge.io/rst.html) (.rst), so that I could "prettify" them with [Python Sphinx](https://www.sphinx-doc.org/en/master/). In this way I could write plain text, and from time to time I would "build" them into HTML with `sphinx`, which would include a search index, which aids in recall. I was aware of [Markdown](https://commonmark.org/) (.md) prior to .rst, but when I found Sphinx, I decided on using .rst for all my documentation ([Why use .rst instead of .md](https://www.ericholscher.com/blog/2016/mar/15/dont-use-markdown-for-technical-docs/))

In 2021 I began thinking about how to improve my use of a computer to function more like a "Second Brain", which involves both the "capture" of information and the "recall" of information. In brief terms, how can I improve on that `git grep`? I started jotting down ideas for a "Personal Knowledge Management" (PKM) system. This led to the assembly of a set of [Requirements](#Requirements).

I began searching for material on this topic and found that the concept of a "Personal Knowledge Management" system and "Second Brain" seemed to have a relatively young but growing community.

- [Second Brain](https://www.buildingasecondbrain.com/)
- [The PARA Method](https://fortelabs.co/blog/para/)
- [Building a Second Brain](https://fortelabs.co/blog/basboverview/)
- [Progressive Summarization](https://fortelabs.co/blog/progressive-summarization-a-practical-technique-for-designing-discoverable-notes/)
- [Building An Idea Generator](https://fortelabs.co/blog/p-a-r-a-iii-building-an-idea-generator/)

This led to a review of current set of note taking applications:

- OneNote
- EverNote
- Notational Velocity (nv)
- nvAlt
- Bear
- ... many others ...

There are a couple of new ones that include a new feature that I had not seen before:

- [Roam](https://roamresearch.com/)
- [Obsidian](https://obsidian.md/)

The discovery of these tools, notably Obsidian, coincided with my parallel work getting started in Data Engineering, which was leading me into setting up an [effective python environment](https://realpython.com/effective-python-environment/). That work was leading me to [vscode](https://code.visualstudio.com/) and [PyCharm](https://www.jetbrains.com/pycharm/). I ended up choosing [Miniconda](https://docs.conda.io/en/latest/miniconda.html) for Python management and ``vscode`` for development.

Then ``vscode`` started to look a lot like ``obsidian``. Then I was looking more into Obsidian's knowledge graph structure, which looked a lot like my attempts at [Mind Mapping](https://en.wikipedia.org/wiki/Mind_map) using [PlantUML](https://plantuml.com/mindmap-diagram). That led me to discover [Foam](https://foambubble.github.io/foam/).

During this time I also found [cheat](https://github.com/cheat/cheat), a command line utility for viewing cheat-sheets for quick reference. It seemed likely that I could write `resources` (notes and text) in [Markdown](https://commonmark.org/) that would work with `cheat`, and with this notion of a PKM. Up to this point, I had been writing journals in [reStructuredText](https://docutils.sourceforge.io/rst.html) (rST or .rst), and not Markdown, because rST offers some utility not found in Markdown, like inline UML and other "directives".

Then I discovered that `sphinx` is capable of parsing both `Markdown` **and** `reStructuredText`. So, it seemed that I could use `vscode` to write `Markdown` and `reStructuredText`, using `sphinx` to publish to HTML, including `UML` when I wanted to, using `foam` for relationship graphing, and `git` for version control, and `cheat` for cheet-sheets.

I felt like I had put together a set of tools and ideas that had captured the ideas I had been turning around in my own head, and now I had a means of building out my toolkit.

## Requirements

- Avoid proprietary tools, use tools with a long standing community, prefer open source.
- Avoid proprietary data formats, write in **plain text** whenever possible.
- Store everything in [Git](https://git-scm.com/) for change control.
- Using a system should be fast, easy, and unobtrusive.
- Data should be searchable for quick recall.
- Data should be "linkable".
- Data should be able to be made pretty for reading like a book or blog.
- It should work for journaling, project management, and research work.
- It should display a Relationship Graph (this is new to me).
- It should support Jupyter Notebooks.
- It should support UML graphs.
- It should be easy to share if desired.
- It should be secret if desired.

## Design

- Install `miniconda` to support multiple Python interpreter versions and other tools.
- Install `vscode` as an editor and development environment.
- Install `cheat` for use with cheatsheets and quick reference material.
- Use `conda` to create a python environment for `vscode` and include `sphinx` and various other modules and extensions.
- Create a git repository and establish a filesystem structure that fits the `PARA` model, including: `projects, areas, resources, archive`
- Add a `journal` directory for the daily journal entries.
- Add `documentation` directory for "long form text". 
- Configure `cheat`'s `conf.py` to point to `resources` for cheat-sheets.
- Write most content in `Markdown` so that `Foam` can graph relations.
- Use Python's `MyST` Markdown dialect for its extensions and directives.
- Note that `sphinx` supports `jupyter` notebooks as well.

## Setup

This is on MacOS X with [Homebrew](https://brew.sh/) installed.

References:

- [mas](https://github.com/mas-cli/mas)
- [Homebrew](https://brew.sh/)
- [Direnv](https://direnv.net/)
- [PlantUML](https://plantuml.com/)
- [Amphetamine](https://apps.apple.com/us/app/amphetamine/id937984704?mt=12)

### First the shell

I use `bash`. Yes, I know about `zsh` but I still use `bash`. I configure my shell with snippets divided by topic that are all sourced from a top level `~/.bashrc`:

    # .bashrc
    # source global definitions
    if [ -f /etc/bashrc ]; then        # redhat style
        . /etc/bashrc
    elif [ -f /etc/bash.bashrc ]; then # debian style
        . /etc/bash.bashrc
    fi
    # Below here are my mods
    function load_dir {
        LOAD_DIR=${1}
        if [ -d $LOAD_DIR -a -r $LOAD_DIR -a -x $LOAD_DIR ]; then
            for i in $LOAD_DIR/*.sh; do
                source $i
            done
        fi
        unset i
    }
    shopt -q login_shell && \
      load_dir ${HOME}/bashrc.d

At this point, further configure `bash` with shell snippets in `~/bashrc.d`.

### Installing the Basics

    # Ensure command line tools are present
    xcode-select --install
    # CLI interface for Mac App Store
    brew install mas
    # Install Homebrew with bash + curl install method
    brew install git-lfs
    brew install direnv
    brew install plantuml
    brew install --cask miniconda
    brew install --cask visual-studio-code
    brew install --cask basictex   # latex for python-sphinx
    sudo tlmgr update --self       # update latex .sty files for latex

Look for `Amphetamine` with mas:

    > mas search amphetamine
       937984704  Amphetamine                    (5.2.2)
    > mas install 937984704 

Note that `direnv` needs an on/off switch in `~/bashrc.d/40_direnv.sh`:

    [[ -x /usr/local/bin/direnv ]] && \
        eval "$(direnv hook bash)"

### Use `conda` to set up a Python (3) interpreter

After you install Miniconda via homebrew, it will automatically update your `~/.bashrc` to enable itself. I move this to a shell snippet `~/bashrc.d/40_conda.sh`:

    test "$VERBOSE" = "true" && echo source $BASH_SOURCE

    show_conda_env() {
        if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
            echo "$(basename $CONDA_DEFAULT_ENV)"
        fi
    }
    export -f show_conda_env

    [[ -x /usr/local/Caskroom/miniconda/base/bin/conda ]] || return 0

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            #export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
            path_push "/usr/local/Caskroom/miniconda/base/bin"
        fi
    fi
    unset __conda_setup

    # Enable autocomplete
    which register-python-argcomplete >/dev/null && \
      eval "$(register-python-argcomplete conda)"
    # <<< conda initialize <<<
    # https://github.com/conda/conda/issues/9392
    # PATH not set by conda activate #9392
    #unset CONDA_SHLVL

Next, the `conda` built in dependency solver is horribly slow. Improve it with the addition of [Mamba](https://github.com/mamba-org/mamba):

    conda install mamba -n base -c conda-forge

Now I want to build the programming environments I know I will want to use. Second Brain only cares about Python 3, but I know I'll have need for Python 2 and R as well:

    mamba create -n py-3.9.5 python=3.9.5
    mamba create -n py-2.7.15 python=2.7.15
    mamba create -n r-3.6.3 r-base=3.6.3 radian openjdk renv

Now I've got these environments:

    conda info --envs
      base                  *  /usr/local/Caskroom/miniconda/base
      py-2.7.15                /usr/local/Caskroom/miniconda/base/envs/py-2.7.15
      py-3.9.5                 /usr/local/Caskroom/miniconda/base/envs/py-3.9.5
      r-3.6.3                  /usr/local/Caskroom/miniconda/base/envs/r-3.6.3

I know I want to enable a given environment when I `cd` into a directory. I do this with `direnv`. I use a particular "layout" that is defined by `~/.direnvrc`:

    layout_conda-venv () {
        # Ref Url: https://github.com/direnv/direnv/wiki/Python
        local CONDA_ENV=$1
        local VENV=$2
        VENV=$(realpath "${VENV}")

        if [[ -n "${CONDA_ENV}" ]]; then
            # If conda base isn't activated, activate it
            . /usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh
            conda activate $CONDA_ENV
        fi
        if [ -n "$VENV" -a -f "${VENV}/bin/activate" ]; then
            # Activate python virtualenv
            source ${VENV}/bin/activate
        fi

        PATH="${VENV}/bin:${PATH}"
        export PATH
    }

    realpath() {
        [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }

So now in a given git repo, like this `second-brain` repo, given that `conda` is enabled, I activate py-3.9.5 and then begin a python **virtual environment**.

    cd ~/git/second-brain               # cd to the base path of the desired environment
    conda activate py-3.9.5             # enable python 3.9.5 with conda
    python -m venv .venv                # create a virtual environment in .venv
    cat > .envrc <<EOF                  # write the .envrc to enable it
    layout conda-venv py-3.9.5 .venv
    unset PS1
    EOF
    conda deactivate                    # deactivate conda
    direnv allow .                      # allow the direnv
    pip install -U setuptools pip       # update the venv
    which python                        # note where python and pip are
    which pip
    pip list
    cd ~                                # see direnv disable when you cd out
    cd ~/git/second-brain               # see direnv enable when you cd in

Now in the `second-brain` repo, update the `.envrc` to add some specifics:

    # This requires conda's base env to be activated already.
    # So I expect `conda` to already be "on"
    layout conda-venv py-3.9.5 .venv
    unset PS1
    # These are variables used by `second-brain`'s `next.sh` script:
    export DATE=`date -j "+%a %b %e, %Y" | sed 's/  / /'`
    export LASTWEEK=`gdate +%V -d 'last week'`
    export WEEKNUM=`date +%V`
    export YEAR=`date +%Y`
    export TOP="./journal"
    export FORMAT="md"
    export LASTLOG=`find -s $TOP -type f -ipath "*daylog.${FORMAT}" | sort -V | tail -n1`
    export LASTDIR="${TOP}/${YEAR}/week-${LASTWEEK}"
    export DIR="${TOP}/${YEAR}/week-${WEEKNUM}"
    export NEXTLOG="${DIR}/${TODAY}-daylog.${FORMAT}"

Now it looks like this when you enter the directory:

    > cd ~/git/second-brain/
    direnv: loading ~/git/second-brain/.envrc
    direnv: export +CONDA_PREFIX_1 +CURL_CA_BUNDLE ~CONDA_DEFAULT_ENV ~CONDA_PREFIX ~CONDA_PROMPT_MODIFIER ~CONDA_SHLVL ~PATH

    > conda info | head -n3

       active environment : py-3.9.5
      active env location : /usr/local/Caskroom/miniconda/base/envs/py-3.9.5

### Some notes about `vscode`

Any VSCode installation will take on some unique features of the user. Here are some notes about mine.

Some keybindings:

    > cat ~/Library/Application\ Support/Code/User/keybindings.json
    // Place your key bindings in this file to override the defaults
    [
        { "key": "ctrl+n", "command": "explorer.newFile" },
        { "key": "alt+tab", "command": "workbench.action.quickSwitchWindow" },
        { "key": "alt+shift+n", "command": "vscodeMarkdownNotes.newNote" },
        // Toggle between terminal and editor focus
        { "key": "ctrl+=", "command": "workbench.action.terminal.focus"},
        { "key": "ctrl+=", "command": "workbench.action.focusActiveEditorGroup", "when": "terminalFocus"}
    ]

Some settings:

    > cat ~/Library/Application\ Support/Code/User/settings.json
    {
        "workbench.colorTheme": "Default Light+",
        "editor.renderWhitespace": "all",
        "explorer.confirmDelete": false,
        "window.zoomLevel": 0,
        "git.confirmSync": false,
        "python.condaPath": "/usr/local/Caskroom/miniconda/base/bin",
        "python.terminal.activateEnvInCurrentTerminal": true
    }

Starting up `vscode` using the Extensions browser, install these extensions with `code --install-extension ...`

    code --install-extension foam
    code --install-extension vscodevim
    code --install-extension snooty
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-vscode-remote.remote-containers

### Some notes about the git repo

Now the `git` repo for this, the `second-brain`, looks like this:

    cd ~/git
    git init second-brain
    cd second-brain
    git lfs install
    git lfs track '*.pdf'
    git lfs track '*.png'
    git lfs track '*.jpg'
    git lfs track '*.svg'
    mkdir doc journal projects areas resources archive

### The Sphinx config

Now supply a `conf.py` file for use with `python-sphinx` (be careful with python whitespace):

    project = 'Second Brain'
    copyright = 'Matthew Callaway, 2021'
    extensions = [
            'sphinxcontrib.jinja',             # Jinja templates
            'sphinxcontrib.plantuml',          # PlantUML renderer
            'sphinx.ext.autodoc',              # Python autodoc
            'sphinx.ext.autosummary',
            'sphinx.ext.coverage',
            'sphinx.ext.graphviz',             # graphviz for 'dot'
            'sphinx.ext.doctest',
            'sphinx.ext.intersphinx',
            'sphinx.ext.todo',
            'sphinx.ext.coverage',
            'sphinx.ext.imgmath',              # for 'math' support
            'sphinx.ext.ifconfig',
            'matplotlib.sphinxext.plot_directive',
            'jupyter_sphinx',                  # for jupyter support
    ]
    plantuml_output_format = 'svg'
    graphviz_output_format = 'svg'
    templates_path = ['templates']
    exclude_patterns = [
      '_layouts',
      '_build',
      '.vscode',
      '.git',
      '.DS_Store',
      '*.yml',
      '*.swp',
      '*.swo',
      '*.pyc',
      '*~',
      'Thumbs.db',
    ]
    html_theme = 'bootstrap'
    import sphinx_bootstrap_theme
    html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()
    html_static_path = ['static']
    from recommonmark.parser import CommonMarkParser
    class CustomCommonMarkParser(CommonMarkParser):
        # https://github.com/readthedocs/recommonmark/issues/177
        # Method used to remove the warning message.
        def visit_document(self, node):
            pass
        # remove this hack once upsteam recommonmark supports inline code
        def visit_code(self, mdnode):
            from docutils import nodes
            n = nodes.literal(mdnode.literal, mdnode.literal)
            self.current_node.append(n)
    from recommonmark.transform import AutoStructify
    def setup(app):
        app.add_source_suffix('.md', 'markdown')
        app.add_source_parser(CustomCommonMarkParser)
        app.add_config_value('recommonmark_config', {
            'parser': 'CustomCommonMarkParser',
            'enable_auto_toc_tree': True,
            'enable_auto_doc_ref': False, # broken in Sphinx 1.6+
            'enable_eval_rst': True,
            'url_resolver': lambda url: '/' + url
        }, True)
        app.add_transform(AutoStructify)

### The Makefile

Now supply a `Makefile` for convenience functions for `python-sphinx`.

I use `make` for some shortcuts to enable daily habits. At the beginning of each day I run:

    make vpn vault next commit

You can probably guess that this:

- starts the VPN connection to work
- authenticates to vault
- begins my next journal entry
- commits pending work

Note that `make next` uses the `./next.sh` shell script which makes use of the `./journal/template.md`. Edit this to taste.

### The Document Tree

The `index.md` file establishes the layout of the content:

    > cat index.md
    # Second Brain

    - [Journal](journal/journal.md)
    - [Projects](projects/projects.md)
    - [Areas](areas/areas.md)
    - [Resources](resources/resources.md)
    - [Contacts](contacts/contacts.md)
    - [Documentation](documentation/documentation.md)
    - [Archive](archive/archive.md)

Note that in order to have Sphinx make HTML files with tables of contents that also
map to a filesystem layout of Markdown files, and to have WikiLink style links work,
we need to match ``# Page Title`` to filename ``page-title.md`` and then have lists
of links like ``- [Page Title](page-title.md)``.

Note that you start out launching `vscode` by invoking: ``code .``

There will be a `.vscode/` directory made in the `second-brain` project directory space, and there will be a `settings.json` file made there. The following is the settings file for my own `~/git/second-brain/.vscode/settings.json` file:

    {
      "editor.minimap.enabled": false,
      "editor.wrappingIndent": "indent",
      "editor.overviewRulerBorder": false,
      "editor.lineHeight": 24,
      "[markdown]": {
        "editor.quickSuggestions": true
      },
      "files.defaultLanguage": "rst",
      "files.exclude": {
        "**/_build": true,
        "**/.vscode": true,
        "**/.*": true
      },
      "files.watcherExclude": {
        "**/node_modules": true
      },
      "git.enableSmartCommit": true,
      "git.postCommitCommand": "sync",
      "markdown.preview.breaks": true,
      "pasteImage.path": "${projectRoot}/attachments",
      "pasteImage.showFilePathConfirmInputBox": true,
      "prettier.singleQuote": false,
      "spellright.notificationClass": "warning",
      "vscodeMarkdownNotes.noteCompletionConvention": "noExtension",
      "vscodeMarkdownNotes.slugifyMethod": "github-slugger",
      "window.autoDetectColorScheme": true,
      "git.ignoreLimitWarning": true,
      "foam.edit.linkReferenceDefinitions": "withExtensions",
      "foam.openDailyNote.directory": "journal",
      "foam.openDailyNote.titleFormat": "yyyymmdd': Day Log' dddd mmmm d yyyy",
      "foam.openDailyNote.filenameFormat": "yyyymmdd-'daylog'",
      "foam.openDailyNote.fileExtension": "rst",
      "foam.files.ignore": [
      ],
      "python.pythonPath": "/usr/local/Caskroom/miniconda/base/envs/py-3.9.5/bin/python",
      "python.terminal.activateEnvironment": true,
      "restructuredtext.builtDocumentationPath" : "${workspaceRoot}/_build/html",
      "restructuredtext.confPath"               : "${workspaceFolder}",
      "restructuredtext.updateOnTextChanged"    : "true",
      "restructuredtext.updateDelay"            : 300,
      "restructuredtext.sphinxBuildPath"        : null
    }

Note in those settings that we set the `python interpreter` to the one in our virtual environment.

### Configuring `cheat`

Now add a `cheat` configuration:

    # In ~/.config/cheat/conf.yml
    # The editor to use with 'cheat -e <sheet>'. Defaults to $EDITOR or $VISUAL.
    editor: vim
    # Should 'cheat' always colorize output?
    colorize: true
    # Which 'chroma' colorscheme should be applied to the output?
    # Options are available here:
    #   https://github.com/alecthomas/chroma/tree/master/styles
    style: monokai
    # Which 'chroma' "formatter" should be applied?
    # One of: "terminal", "terminal256", "terminal16m"
    formatter: terminal16m
    # Through which pager should output be piped? (Unset this key for no pager.)
    pager: less -FRX
    cheatpaths:
      - name: second-brain-resources
        path: ~/git/second-brain/resources
        tags: [ brain, resources ]
        readonly: true
      - name: second-brain-contacts
        path: ~/git/second-brain/contacts
        tags: [ brain, contacts ]
        readonly: true
      - name: second-brain-journal
        path: ~/git/second-brain/journal
        tags: [ brain, journal ]
        readonly: true
      - name: second-brain-areas
        path: ~/git/second-brain/areas
        tags: [ brain, areas ]
        readonly: true

Now, as you add content to the `./resources` directory, `cheat` can see it via:

    cheat -t brain -l
    cheat -t resources -s something

## Start It up

At this point, I can start `code .` within the `second-brain` directory to start working. Or launch `Visual Studio Code` from the application launcher, then open `second-brain` as a Project.

## What Do I Do Now?

So recall how things are organized:

- **Journal** : Record stream of consciousness activities, organize thoughts, keep daily notes.
- **Resources** : Add short specific notes about things, using keywords where helpful. Code snippets, solutions to problems.
- **Projects** : Keep track of time-based, actionable work in `projects`, these must be clearly defined, with goals, and tasks and timelines.
- **Areas** : Keep track of less actionable work in `areas`, these are less well defined with no timelines, but having standards of practice.
- **Documentation** : Write long form how-tos, papers, presentations here.
- **Contacts** : Write notes about people here.
- **Use WikiLink** : Add WikiLinks with `[[word-dash-word]]` format to link content for the Foam Graph.
- **Use cheat** : Use `cheat` to quickly find notes in resources.

Every day when you sit down:

- Begin a new journal entry with `make next commit`.
- Keep track of work carried over day to day.
- At the end of each week, synthesize the work of the week, progress, goals.
- Each month review links made, update projects, make higher level progress.

Over time your `resources` and `contacts` grow with specific topics and people. Your `journal` grows with daily work. Think about how to map this to `projects`. Again "Projects" have goals and timelines, while "Areas" are areas of focus that you return to from time to time, and have some similar characteristics to projects, but do not have timelines. For example, one area I have is "Project Management". I return to that topic from time to time but have no specific deliverables or timelines, so it's an "Area" for me.

As the use of links grows, so does the Foam Graph. Note the isolated points that have no connections. *Should there be connections*? What does it mean for a contact or topic to not relate to anything else? Maybe that's ok, but maybe it will reveal information that is surprising and useful.

## The Big Questions

- Does journaling fit in my daily habits?
- Can I adjust my point of view: daily, weekly, monthly, quarterly, annual reviews?
- Is this setup easy enough to use to aid in synthesizing data through these points of view?
- Will the Foam Graph lead to new insights?

Backlinking is described as a key technique. Will it lead to new insights?

- [Backlinks in knowledge management systems](https://notes.andymatuschak.org/Backlinks_can_be_used_to_implicitly_define_nodes_in_knowledge_management_systems)
- [The state of backlinks](https://forum.obsidian.md/t/the-state-of-backlinks/2732)
