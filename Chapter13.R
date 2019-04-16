library(tidyverse)
library(lubridate)
library(nycflights13)

today()
now()

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")
ymd(20170131)

ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

ymd(20170131, tz = "UTC")

flights %>% 
  select(year, month, day, hour, minute)

flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(
    departure = make_datetime(year, month, day, hour, minute)
  )

make_datetime_100 <- function(year, month, day, time){
  make_datetime(year, month, day, time %% 100, time %% 100)
}

flights_dt <- flights %>%
  filter(!is.na(dep_time), !is.na(arr_time)) %>%
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(
      year, month, day, sched_dep_time
    ),
    sched_arr_time = make_datetime_100(
      year, month, day, sched_arr_time
    )
  ) %>%
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt

flights_dt %>% 
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth = 86400)

flights_dt %>%
  filter(dep_time < ymd(20130102)) %>%
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth = 600) # 600 s = 10 minutes

as_datetime(today())
as_date(now())

as_datetime(60 * 60 * 10)
as_date(365 * 10 + 2)

datetime <- ymd_hms("2016-07-08 12:34:56")
datetime
year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)

month(datetime, label = TRUE)
wday(datetime, label = TRUE, abbr = FALSE)

flights_dt %>%
  mutate(wday = wday(dep_time, label = TRUE)) %>%
  ggplot(aes(x = wday)) +
  geom_bar()

flights_dt %>%
  mutate(minute = minute(dep_time)) %>%
  group_by(minute) %>%
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n = n()) %>%
  ggplot(aes(minute, avg_delay)) +
  geom_line()

sched_dep <- flights_dt %>%
  mutate(minute = minute(sched_dep_time)) %>%
  group_by(minute) %>%
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n = n())
ggplot(sched_dep, aes(minute, avg_delay)) +
  geom_line()

ggplot(sched_dep, aes(minute, n)) +
  geom_line()

flights_dt %>%
  count(week = floor_date(dep_time, "week")) %>%
  ggplot(aes(week, n)) +
  geom_line()

(datetime <- ymd_hms("2016-07-08 12:34:56"))

h_age <- today() - ymd(19791014)
h_age
as.duration(h_age)
dseconds(15)
dminutes(10)
dhours(c(12, 24))

tomorrow <- today() + ddays(1)
tomorrow
last_year <- today() - dyears(1)
last_year
one_pm <- ymd_hms(
  "2016-03-12 13:00:00",
  tz = "America/New_York"
)
one_pm
one_pm + days(1)
ymd("2016-01-01") + dyears(1)
ymd("2016-01-01") + years(1)

flights_dt %>% 
  filter(arr_time < dep_time) %>% 
  View()

flights_dt <- flights_dt %>% 
  mutate(
    overnight = arr_time < dep_time,
    arr_time = arr_time + days(overnight * 1),
    sched_arr_time = sched_arr_time + days(overnight * 1)
  )
flights_dt %>% 
  filter(overnight, arr_time < dep_time)

years(1) / days(1)
next_year <- today() + years(1)
(today() %--% next_year) / ddays(1)

(today() %--% next_year) %/% days(1)

Sys.timezone()
length(OlsonNames())
head(OlsonNames())

