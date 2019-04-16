library(tidyverse)
library(forcats)

x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)
y1
sort(y1)

y2 <- factor(x2, levels = month_levels)
y2
y2 <- parse_factor(x2, levels = month_levels)
factor(x1)

f1 <- factor(x1, levels = unique(x1))
f1

f2 <- x1 %>% 
  factor() %>% 
  fct_inorder()
f2
levels(f2)

gss_cat
gss_cat %>% 
  count(race)

ggplot(gss_cat, aes(race)) +
  geom_bar()
ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)

relig <- gss_cat %>% 
  group_by(relig) %>% 
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig, aes(tvhours, relig)) + geom_point()
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) + geom_point()
relig %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

rincome <- gss_cat %>%
  group_by(rincome) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(
  rincome,
  aes(age, fct_reorder(rincome, age))
) + geom_point()

ggplot(
  rincome,
  aes(age, fct_relevel(rincome, "Not applicable"))
) + 
  geom_point()

by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  mutate(prop = n / sum(n))
ggplot(by_age, aes(age, prop, color = marital)) +
  geom_line(na.rm = TRUE)
ggplot(
  by_age,
  aes(age, prop, color = fct_reorder2(marital, age, prop))
) +
  geom_line() +
  labs(color = "marital")

gss_cat %>% 
  mutate(marital = marital %>% fct_infreq()) %>% 
  ggplot(aes(marital)) +
  geom_bar()

gss_cat %>% count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"
                              = "Strong republican",
                              "Republican, weak"
                              = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"
                              = "Not str democrat",
                              "Democrat, strong"
                              = "Strong democrat"
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"
                              = "Strong republican",
                              "Republican, weak"
                              = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"
                              = "Not str democrat",
                              "Democrat, strong"
                              = "Strong democrat",
                              "Other"
                              = "No answer",
                              "Other"
                              = "Don't know",
                              "Other"
                              = "Other party"
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%
  count(relig, sort = TRUE) %>%
  print(n = Inf)
