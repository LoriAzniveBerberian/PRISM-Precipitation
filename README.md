# PRISM Daily Precipitation Download

R script to bulk-download daily 4km precipitation grids from the [PRISM Climate Group](https://prism.oregonstate.edu/) for California.

## What it does

- Checks which months are already downloaded in your local archive
- Downloads only the missing months (avoids re-downloading)
- Fetches daily precipitation (D1) at 4km resolution as `.bil` rasters
- Covers Feb 2016 through Dec 2024 (adjustable in script)

## Files

| File | Description |
|---|---|
| `PRISM_API.R` | Download script. Update `dl_dir` path before running. |

## Requirements

```r
install.packages(c("prism", "stringr", "lubridate"))
```

## Usage

1. Open `PRISM_API.R`
2. Update `dl_dir` to your desired download folder
3. Adjust the date range in the `seq()` call if needed
4. Run the script in R or RStudio

## Data Source

- **PRISM Climate Group**, Oregon State University
- Website: https://prism.oregonstate.edu/
- R package docs: https://docs.ropensci.org/prism/
- Variable: `ppt` (daily total precipitation, mm)
- Resolution: 4km (D1)
- Format: `.bil` (band interleaved by line)

## Notes

- The PRISM API was updated in September 2025. The `prism` R package v0.3.0+ supports the new API.
- If you have data from the old API, start a fresh download directory to avoid mixing formats.
- Downloads may take a while depending on the date range. The script sets `options(timeout = 600)` to allow for slow connections.
