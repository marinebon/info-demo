#!/usr/bin/env Rscript
#
# run w/ Rscript like:
# # Rscript create_info_site.R

# this script assumes you have already installed the infographiq package
# devtools::install_github('marinebon/infographiq')
infographiq::create_info_site(
    render_modals = T
)
