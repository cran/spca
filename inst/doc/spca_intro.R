## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "figures/intro-"
)
#  ,out.width = "60%"

## ----inst_cran,  eval = FALSE-------------------------------------------------
#  install.packages("spca")

## ----inst_gib, , eval = FALSE-------------------------------------------------
#  remotes::install_github("merolagio/spca")

## ----load_data, echo = TRUE, message = FALSE, warning = FALSE-----------------
library(spca)
data(holzinger)
dim(holzinger)
holzinger_scales

## ----pca_checks, message = FALSE, warning = FALSE, fig.show = "hold", out.width = "47%", fig.width = 4, fig.height = 4----
ho_pca = pca(holzinger, screeplot =  TRUE, qq_plot = TRUE)
summary(ho_pca,cols = 10)

## ----run_spca, message = FALSE, warning = FALSE-------------------------------
myspca = spca(holzinger, n_comps = 4)

## ----methods, message = TRUE, warning = FALSE, fig.height=5, fig.width = 5----
myspca # print

summary(myspca, cor_with_pc = TRUE)

plot(myspca, plot_type = "bar")

#sPCs correlation
show_correlations(myspca)

## ----circular, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 3----
plot(myspca, plot_type = "c") # "c" for "circular"

## ----heatmap, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 4----
plot(myspca, plot_type = "h", controls = list(legend_position = "b")) # "h" is enough to call "heatmap" type and "b" to indicate "bottom".

## ----groups, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 4----
plot(myspca, plot_type = "bars", variable_groups = holzinger_scales, controls = list(legend_position = "right")) 

aggregate_by_group(myspca,groups = holzinger_scales)

## ----spca90, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 5----
myspca90 = spca(holzinger, n_comps = 4, alpha = 0.9)

compare_spca(obj_list = list(myspca, myspca90), 
             methods_names = c("alpha = 95", "alpha = 90"))

