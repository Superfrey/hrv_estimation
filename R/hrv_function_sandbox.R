#load an library package

library('RHRV')
library(vroom)
library(here)
library(tidyverse)
file <- here("data-raw/rr-interval/002.txt")
hrv_test<- readLines(file)
hrv_test <- as.numeric(hrv_test)
vroom(file)
mylist <- seq(from = 600, to = 1000, length.out = 100)
mylist <- runif(n = 100, min = 600, max = 1000)

#hrv_file <- function(hrv_id_v) {
 #   data("HRVData")
  #  data("HRVProcessedData")
   # hrv_data = RHRV::CreateHRVData()
    #hrv_data = RHRV::SetVerbose(hrv_data, TRUE )
    #hrv_data = RHRV::LoadBeatRR(hrv_data, hrv_id_list, verbose = NULL)
    #hrv_data = RHRV::BuildNIHR(hrv_data, verbose = NULL)
    #hrv_data = RHRV::FilterNIHR(hrv_data)
    #hrv_data = RHRV::InterpolateNIHR (hrv_data, freqhr = 4)
    #hrv_data = RHRV::CreateTimeAnalysis(hrv_data)
    #hrv_estimates <- c(hrv_data$TimeAnalysis$SDNN)
#return(hrv_estimates)
#    }

#test dataset for hrv

hrv_test <- cumsum(hrv_test/1000)

my_data <- CreateHRVData() %>%
    LoadBeatVector(hrv_test) %>%
    BuildNIHR()  %>%
    FilterNIHR() %>%
    InterpolateNIHR() %>%
    CreateTimeAnalysis()



# MAKE A NUMERIC LIST OF VALUE BASED ON COLUMN WITH HR OR IBI
# EXTRACT COLUMN AND INSERT BY ID

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

rhrvdatatest <- hrv_file(hrv_test)
rhrvdatatest

# Long format
# Long format #solution could be in for function...
rhrv_df <- function(df_rr_long, id_rr, rr_data_column) {
    summarised_hrv <- df_rr_long %>%
        group_by(id_rr) %>%
        select(rr_data_column)

    rhrv_file(summarised_hrv)

    return(summarised_hrv)
}

rhrv_df()
# tester

rr_data <- RHRV::CreateHRVData() %>%
    RHRV::LoadBeatVector(hrv_test) %>%
    RHRV::BuildNIHR()  %>%
    RHRV::FilterNIHR() %>%
    RHRV::InterpolateNIHR() %>%
    RHRV::CreateTimeAnalysis()

r3::check_setup()
158.81411  64.25367
sdnn <- hrvdatatest$TimeAnalysis[[1]]$SDNN
sdnn

CreateHRVData() %>%
    LoadBeatVector(hrv_test) %>%
    BuildNIHR()  %>%
    InterpolateNIHR() %>%
    CreateTimeAnalysis()

hrv_file("data-raw/rr-interval/000.txt")

# HRVData structure containing the heart beats
data("HRVData")
# HRVData structure storing the results of processing the
# heart beats: the beats have been filtered, interpolated, ...
data("HRVProcessedData")

hrv_data  = CreateHRVData()
hrv_data = SetVerbose(hrv_data, TRUE )
hrv_data = LoadBeatRR(hrv_data, "data-raw/rr-interval/000.txt", verbose = NULL, datetime = "1/1/2009 12:00:00")
hrv_data = BuildNIHR(hrv_data, verbose = NULL)
hrv_data = FilterNIHR(hrv_data)
hrv_data = InterpolateNIHR (hrv_data, freqhr = 4)

PlotNIHR(hrv_data)
PlotHR(hrv_data)


hrv_data = CreateTimeAnalysis(hrv_data, size = 1000000)
hrv_data = CreateFreqAnalysis(hrv_data)
hrv_data = SetVerbose(hrv_data,TRUE)
hrv_data = CalculatePowerBand(hrv_data , indexFreqAnalysis= 1,
                              size = 300, shift = 30 )
```

```{r}
test$hrv[1] <- hrv_data$TimeAnalysis$SDNN
```

# RHRV described workflow
data("HRVData")
data("HRVProcessedData")
hrv_data = RHRV::CreateHRVData()
hrv_data = RHRV::SetVerbose(hrv_data, TRUE )
hrv_data = RHRV::LoadBeatVector(hrv_data, hrv_test, verbose = NULL)

hrv_data = RHRV::BuildNIHR(hrv_data, verbose = NULL)
hrv_data$Beat$RR <- hrv_data$Beat$RR/1000
hrv_data$Beat$niHR <- hrv_data$Beat$niHR*1000
hrv_data = RHRV::FilterNIHR(hrv_data)
hrv_data = RHRV::InterpolateNIHR (hrv_data, freqhr = 4)
hrv_data = RHRV::CreateTimeAnalysis(hrv_data)

hrv_data$TimeAnalysis$rMSSD
hrv_estimates <- hrv_data$TimeAnalysis$SDNN
hrv_estimates




my_data$FreqAnalysis

hrvdatatest <- hrv_file(hrv_test)

PlotHR(hrvdatatest)


##Hello JOE!!!!##
usethis::use_git_config(user.name="superfrey", user.email="jonasfrschaarup@gmail.com")
