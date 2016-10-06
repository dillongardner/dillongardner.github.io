#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if(length(args) != 1){
  stop("Must pass file to be knitted")
}

KnitPost <- function(input, base.url = "/") {
  require(knitr)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("figures/", sub(".Rmd$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}
KnitPost(args[1])
