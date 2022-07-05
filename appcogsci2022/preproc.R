library(tidyverse)

dir()
#read_csv("HSE-raw-data.csv")
#str(ds)


# str(HSE_raw_data)
conds <- tibble(number = c(1,3,4,7,8,10,12,14,16,17,18,20,21,23,27,28,32,33,35,37,39,41,45,47,49,51,52,53,55,56,57,59,60,62,63,64,66,68,70,71,72,73,74,76,77,78,79,80),
                cond = c("refl3", "ungram", "refl1", "prn3", "refl1", "refl1", "prn1", "refl3", "prn3", "ungram", "prn3", "refl1", "refl3", "prn1", "refl3", "ungram", "ungram", "refl1", "ungram", "prn1", "refl1", "ungram", "ungram", "prn1", "refl3", "refl1", "ungram", "refl3", "prn3", "ungram", "prn1", "refl3", "ungram", "prn1", "ungram", "prn3", "ungram", "ungram", "prn3", "ungram", "prn1", "ungram", "prn3", "refl1", "ungram", "refl3", "prn1", "prn3"))

readxl::read_excel("/Users/antonangelgardt/Downloads/HSE-raw-data.xlsx") %>% 
  pivot_longer(cols = 3:50, names_to = "item") %>%
  rename("id" = `Response ID`,
         "time" = `Time Taken to Complete (Seconds)`) %>% 
  separate(item, into = c("number", "item", "item2"), sep = "\\. ") %>% 
  unite("item", 5:6) %>%
  mutate(number = as.numeric(number),
         item = str_replace_all(item, "_", " "),
         item = str_replace_all(item, "NA", "")) %>%
  full_join(conds) %>% 
  write_csv("ajt_data.csv")

read.csv("ajt_data.csv") %>% View



taia <- read_csv("https://github.com/angelgardt/taia/raw/master/data/taia.csv")

str(taia)
nrow(taia)

taia %>% 
  slice(sample(1:495, 50)) %>% 
  select(
    paste0(
      rep(c("pr", "co", "ut", "fa", "de", "un"), each = 10),
      rep(c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10"), times = 6)
    )
  ) %>% 
  mutate(id = 1:50) %>% 
  write_csv("taia_sample.csv")
