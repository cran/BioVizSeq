options(warn = -1)

library(shiny)
library(shinythemes)
library(shinydisconnect)
library(shinydashboard)
library(shinycssloaders)
library(shinyWidgets)
library(DT)

library(BioVizSeq)
library(stringr)

library(ggplot2)
library(ggtree)
library(patchwork)
library(treeio)

library(rmarkdown)

source("script/homepage.R")
source("script/aboutpage.R")

source("script/mod_meme.R")
source("script/mod_pfam.R")
source("script/mod_gff.R")
source("script/mod_cdd.R")
source("script/mod_smart.R")
source("script/mod_plantcaresub.R")
source("script/mod_plantcareloc.R")
source("script/mod_plot.R")
source("script/mod_gffplot.R")
source("script/mod_memeplot.R")
source("script/mod_pfamplot.R")
source("script/mod_cddplot.R")
source("script/mod_smartplot.R")
source("script/mod_plantcareplot.R")
source("script/mod_plantcareplot2.R")
source("script/mod_advplot.R")
source("script/mod_advplot2.R")