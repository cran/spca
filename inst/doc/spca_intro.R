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
summary(ho_pca, cols = 10)

## ----run_spca, message = FALSE, warning = FALSE-------------------------------
ho_spca = spca(holzinger, n_comps = 4)

## ----methods, message = TRUE, warning = FALSE, fig.height = 5, fig.width = 5----
ho_spca # print

summary(ho_spca, cor_with_pc = TRUE)

plot(ho_spca, plot_type = "b")

#sPCs correlation
show_correlations(ho_spca)

## ----spca_vs_pca, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 5----
compare_spca(list(ho_pca, ho_spca), variable_groups = holzinger_scales, 
             x_axis_var_names = FALSE,  methods_names = c("PCA", "SPCA")
             )

## ----circular, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 3----
plot(ho_spca, plot_type = "c",     # "c" for "circular"
     controls = list(variable_names = "auto"))

## ----heatmap, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 4----
plot(ho_spca, plot_type = "h", controls = list(legend_position = "b")) # "h" is enough to call "heatmap" type and "b" to indicate "bottom".

## ----groups, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 4----
plot(ho_spca, plot_type = "bars", variable_groups = holzinger_scales, controls = list(legend_position = "right")) 

aggregate_by_group(ho_spca, variable_groups = holzinger_scales)

## ----spca90, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 5----
ho_spca90 = spca(holzinger, n_comps = 4, alpha = 0.9)

compare_spca(obj_list = list(ho_spca, ho_spca90), 
             methods_names = c("alpha = 95", "alpha = 90"))

