library(tidyverse)
install.packages("pryr")
library(pryr)

typeof(letters)
typeof(1:10)
x <- list("a", "b", 1:10)
x
length(x)

1:10 %% 3 == 0
c(TRUE, TRUE, FALSE, NA)
typeof(1)
typeof(1L)
1.5L

x <- sqrt(2) ^ 2
x
x - 2
x - 2 == 0
dplyr::near(x, 2)
dplyr::near(x - 2, 0)

c(-1, 0, 1) / 0
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)

NA
NA_integer_
NA_real_
NA_character_

x <- sample(20, 100, replace = TRUE)
x
y <- x > 10
y
sum(y)
mean(y)

if (length(x) > 0) {
  # 何かする
}

typeof(c(TRUE, 1L))
#> [1] "integer"
typeof(c(1L, 1.5))
#> [1] "double"
typeof(c(1.5, "a"))
#> [1] "character"

sample(10) + 100
runif(10) > 0.5

tibble(x = 1:4, y = 1:2)
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
x[c(1, 1, 5, 5, 5, 2)]
x[c(-1, -3, -5)]
x[c(1, -1)]
x[0]

x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]
x[x %% 2 == 0]
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

x <- list(1, 2, 3)
x
str(x)
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

y <- list("a", 1L, 1.5, TRUE)
str(y)

z <- list(list(1, 2), list(3, 4))
str(z)

x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
a
a[1:2]
str(a[1:2])
str(a[4])

str(a[[1]])
str(a[1])
str(a[[4]])
a$a
a[["a"]]

x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)
x
as.Date
methods("as.Date")
getS3method("as.Date", "default")

x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)

x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)
typeof(x)
attributes(x)

attr(x, "tzone") <- "US/Pacific"
x
#> [1] "1969-12-31 17:00:00 PST"
attr(x, "tzone") <- "US/Eastern"
x
#> [1] "1969-12-31 20:00:00 EST"
y <- as.POSIXlt(x)
typeof(y)
attributes(y)
tb <- tibble::tibble(x = 1:5, y = 5:1)
tb
typeof(tb)
attributes(tb)
