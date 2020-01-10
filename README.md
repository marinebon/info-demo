
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

