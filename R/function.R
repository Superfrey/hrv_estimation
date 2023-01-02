## load package

library('RHRV')
library(vroom)
library(here)
library(tidyverse)

# Function for getting individual HRV estimates # works well

rhrv_file <- function(hrv_id_values) {
    hrv_id_values <- cumsum(hrv_id_values/1000)

    rr_data <- RHRV::CreateHRVData() %>%
        RHRV::LoadBeatVector(hrv_id_values) %>%
        RHRV::BuildNIHR()  %>%
        RHRV::FilterNIHR() %>%  #consider with an without
        RHRV::InterpolateNIHR() %>%
        RHRV::CreateTimeAnalysis()

    hrv_estimates <- c(SDNN = rr_data$TimeAnalysis[[1]]$SDNN,
                       RMSSD = rr_data$TimeAnalysis[[1]]$rMSSD,
                       pNN50 = rr_data$TimeAnalysis[[1]]$pNN50,
                       SDSD = rr_data$TimeAnalysis[[1]]$SDSD,
                       SDANN = rr_data$TimeAnalysis[[1]]$SDANN)

    return(hrv_estimates)
}

# loop function for doing hrv analysis on a merged dataset with all individuals
# df_rr_long = data frame with all individuals in long format with interbeat intervals
# rr_df$user_id = user_id
# rr_data_column = column with IBI values

# this does not work

##Error in `select()`:
#! Can't subset columns with `as.numeric(rr_data_column)`.
#✖ Can't convert from `as.numeric(rr_data_column)` <double> to <integer> due to loss of precision.
#Backtrace:
#   1. global rhrv_df(rr_df, rr_df$user_id, rr_df$ibi_s)
# 20. rlang::cnd_signal(x)

rhrv_df <- function(df_rr_long, id_rr, rr_data_column) {
    id <- c(id_rr)

    df <- data.frame(id_rr)

    for (i in id) {
        summarised_hrv <- df_rr_long %>%
            filter(id_rr == i) %>%
            select(as.double(rr_data_column))

        hrv_indices<- rhrv_file(summarised_hrv)
    }

    df <- rbind(df,hrv_indices)

    return(df)
}

rhrv_df(rr_df,rr_df$user_id, rr_df$ibi_s)

