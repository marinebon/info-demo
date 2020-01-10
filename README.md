
<!-- 
To update table of contents run: `cat README.md | ./gh-md-toc -` 
Uses: https://github.com/ekalinin/github-markdown-toc
-->
* [Create Rmd website](#create-rmd-website)
* [Add infographic dependencies](#add-infographic-dependencies)
* [Insert infographic](#insert-infographic)
* [Build website](#build-website)
* [View website](#view-website)
* [technical implementation](#technical-implementation)
   * [core files: .svg, .csv](#core-files-svg-csv)
   * [html and js/css dependencies](#html-and-jscss-dependencies)

## Create Rmd website

Create Rmd website, per [10.5 rmarkdown’s site generator | R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html#a-simple-example).


First, we need a configuration file _site.yml:

```yaml
name: "my-website"
navbar:
  title: "My Website"
  left:
    - text: "Home"
      href: index.html
    - text: "About"
      href: about.html
output_dir: "docs"
```

Then two Rmd files, `index.Rmd`:

```yaml
---
title: "My Website"
---

Hello, Website!
```

and `about.Rmd`:

```yaml
---
title: "About This Website"
---
```

## Add infographic dependencies

- `libs/`
- `_svg-html_child.Rmd`

## Insert infographic

- `svg/`
- `modals/`

Implement the infographics using a combination of [Rmd parameters](https://rmarkdown.rstudio.com/developer_parameterized_reports.html%23parameter_types%2F) and an [Rmd child document](https://yihui.org/knitr/demo/child/).

For example:

    ```
    ---
    title: "Pelagic"
    params:
      svg: "svg/cinms_pelagic.svg"
      csv: "svg/svg_links.csv"
    ---
    
    ```{r svg, child = '_svg-html_child.Rmd'}
    ```

So the infographic rendering is handled by the child doc [`_svg-html_child.Rmd`](https://github.com/marinebon/cinms/blob/master/_svg-html_child.Rmd) using the parameters `svg` and `csv`.


## Build website

Build tab > Build Website button in RStudio or `rmarkdown::render_site()`.

## View website

```r
servr::httd("docs")
```

## technical implementation

The illustration in scalable vector graphics (`.svg`) format has individual elements given an identefier (ie `id`) which are linked to popup (ie "modal") windows of content using a simple table in comma-seperated value (`.csv`) format using [d3](https://d3js.org).

### core files: `.svg`, `.csv`

These two files are at the core of the infographic construction:

1. **illustration**: [`cinms_pelagic.svg`](https://github.com/marinebon/cinms/blob/master/svg/cinms_pelagic.svg) 
1. **table**: [`svg_links.csv`](https://github.com/marinebon/iea-ak-info/blob/master/svg/svg_links.csv) 

Each `link` in the table per element identified (`id`) is the page of content displayed in the modal popup window when the given element is clicked. The `title` determines the name on hover and title of the modal window.

### html and js/css dependencies

The illustration (`.svg`) and table (`.csv`) get rendered with the `link_svg()` function (defined in `infographiq.js`) with the following HTML:

```html
<!-- load dependencies on JS & CSS -->
<script src='https://d3js.org/d3.v5.min.js'></script>
<script src='infographiq.js'></script>

<!-- add placeholder in page for placement of svg -->
<div id='svg'></div>

<!-- run function to link the svg -->
<script>link_svg(svg='svg/cinms_pelagic.svg', csv='svg/svg_links.csv');</script>
```

The modal popup windows are rendered by [Bootstrap modals](https://getbootstrap.com/docs/3.3/javascript/#modals). This dependency is included with the default Rmarkdown rendering, but if you need to seperately include it then add this HTML:

```html
<!-- load dependencies on JS & CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
```


