# info-fk: Infographics for Florida Keys

This is a simplified demonstration of how to use the [`infographiq`](https://github.com/marinebon/infographiq) package to create your own interactive infographics. This repository contains everything needed to generate the static html website hosted by github in the `./docs` folder.

## getting started

To get started making your own infographic you can use this repository as a starting point. Simply clone or download thi repository, start editing, and building your site using `infographiq::create_info_site()`.

## overview

A basic overview of the functionality is given below. It is recommended that you browse both the code and the resulting website (at https://usf-imars.github.io/info-demo/) as you read through this overview.

Using the data in this repo, the website is generated into the `./docs` folder by running `create_info_site.R`. Github can then host the website from within the `./docs` directory.

We create 2 infographics here: 1. corals 2. seagrass. Images for these infographics are in the `./svg` directory and can be opened using inkscape.

The two svg files are refrenced by name in `svg_elements.csv`. In this file we define three species that we want to make interactive 1. stony corals, 2. lionfish, and 3. parrotfish. The `svg_id` in this file must match the element id set in the svg file (under object properties in inkscape). Note that each svg_id must be unique, so lionfish-2 and stony-coral-2 is used in seagrass.svg.

For parrotfish, we want to include some text in the "modal" popup window which appears when the parrotfish silhoutte is clicked. To do this we created a file in markdown format at `./captions/parrotfish.md` and give this value in the `svg_elements.csv` column `modal_after` so that the text is shown after all plots. We do the same for lionfish (and lionfish-2), but use column `modal_before` so that the text is shown before all of the plots.

In addition to the `modal_before` and `modal_after` texts, we add a caption to individual plots using `plot_caption` in `plot_indicators.csv` for the simpson & shannon diversity index plots of parrotfish.

For the plots that show within a modal popup, we use `plot_indicators.csv`. In this file we give the `svg_id` that matches with the ids in the svg file(s) and in `svg_elements.csv`, along with the details to create the plot.

For most of our plots, we let infographiq use its default plotting function (`plot_dygraph_timeseries`), but for the spiny lobster we use the `plotting_function_call` column in `plot_indicators.csv` to change the default behavior.
We use `plot_none` to tell infographiq to use the `plot_none.rmd.brew` template, which does nothing instead of creating a plot.
We also put R code directly into this cell (wrapped in quotes `"` and quotes within the code are doubled) to create custom plots - for this example we just use the `print` function, but any arbitrary R code can be executed in this way and the output will be put in the modal.
