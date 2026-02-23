# download_prism_D1_to_raw.R

library(prism)
library(stringr)
library(lubridate)

# 0) allow long downloads
options(timeout = 600)

# 1) point PRISM at your “raw” folder
dl_dir <- "/Users/loriberberian/Desktop/Chapter1/Data/Precip/raw"
dir.create(dl_dir, recursive=TRUE, showWarnings=FALSE)
prism_set_dl_dir(dl_dir)

# 2) list everything already in your PRISM archive
all_archived <- prism_archive_ls()

# 3) select only the D1 daily ppt entries
ppt_archived <- grep("PRISM_ppt_stable_4kmD1_\\d{8}_bil", all_archived, value = TRUE)

# 4) pull out their dates
got_dates <- ymd(str_extract(ppt_archived, "\\d{8}"))

# 5) collapse to year-months you already have
have_months <- unique(format(got_dates, "%Y-%m"))

# 6) build the full sequence Jan 2000 → Dec 2024
all_months  <- format(
  seq(as.Date("2016-02-29"), as.Date("2024-12-01"), by = "month"),
  "%Y-%m"
)

# 7) find the missing ones
to_do <- setdiff(all_months, have_months)

# 8) download only the missing D1 .zip bundles
for (yrmo in to_do) {
  start_date <- paste0(yrmo, "-01")
  end_date   <- format(
    seq(as.Date(start_date), length = 2, by = "1 month")[2] - days(1),
    "%Y-%m-%d"
  )
  message("Downloading ", start_date, " → ", end_date)
  get_prism_dailys(
    type    = "ppt",
    minDate = start_date,
    maxDate = end_date,
    keepZip = TRUE
  )
}
zipfiles <- list.files("/Users/loriberberian/Desktop/Chapter1/Data/Precip/raw",
                       pattern="\\.zip$", full.names=TRUE)
for (z in zipfiles) {
  unzip(z, exdir="/Users/loriberberian/Desktop/Chapter1/Data/Precip/raw")
}


message("All PRISM D1 .bil files now in: ", dl_dir)
