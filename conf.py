#! /usr/bin/env python

# -- Project information
project = 'Personal Brain'
copyright = 'Matthew Callaway, 2021'

# -- General configuration
# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
        'myst_parser',                     # MyST Markdown Parser
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
        'nbsphinx',                        # for jupyter support
]

myst_commonmark_only = False
myst_update_mathjax = False

# Using SVG output instead of PNG allows embedding HTML links in UML.
# It also allows for resizing images without loss of quality.
plantuml_output_format = 'svg'
graphviz_output_format = 'svg'

# Add any paths that contain templates here,
# relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = [
  '_layouts',
  '_build',
  '.venv',
  '.vscode',
  '.git',
  '.DS_Store',
  '*.yml',
  '*.swo',
  '*.pyc',
  '*~',
  'Thumbs.db',
  '**/.*.swp',
  '**/header.md',
  '**/template.md',
  'README.md',
]

# For bootstrap theme: https://pypi.org/project/sphinx-bootstrap-theme/
# I discovered this theme with Seaborn and thought it looked nice
html_theme = 'bootstrap'
import sphinx_bootstrap_theme
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
#html_static_path = []

