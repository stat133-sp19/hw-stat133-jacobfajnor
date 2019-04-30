context("Test Functions")

source("../../R/functions.R")

test_that("test that check_prob works", {
  expect_true(check_prob(.5))
  expect_length(check_prob(.5), 1)
  expect_error(check_prob(1.5), "prob has to be a number between 0 and 1")
}
)

test_that("test that check_trials works", {
  expect_true(check_trials(5))
  expect_length(check_trials(5), 1)
  expect_error(check_trials(5.5), "invalid trials value")
}
)

test_that("test that check_success works", {
  expect_true(check_success(5, 2))
  expect_length(check_success(5, 2), 1)
  expect_error(check_success(5, 10), "invaled success and trial combination")}
)

test_that("test that aux_mean works", {
  expect_equal(aux_mean(5, .5), 2.5)
  expect_length(aux_mean(5, .5), 1)
  expect_equal(aux_mean(10, .2), 2)
})

test_that("test that aux_variance works", {
  expect_equal(aux_variance(5, .5), 1.25)
  expect_length(aux_variance(5, .5), 1)
  expect_equal(aux_variance(10, .2), 1.6)
})

test_that("test that aux_mode works", {
  expect_equal(aux_mode(5, .5), 3)
  expect_length(aux_mode(5, .5), 1)
  expect_equal(aux_mode(10, .2), 2)
})

test_that("test that aux_skewness works", {
  expect_equal(aux_skewness(5, .5), 0)
  expect_length(aux_skewness(5, .5), 1)
  expect_equal(aux_skewness(10, .2), .4743416 + 4.9e-08)
})

test_that("test that aux_kurtosis works", {
  expect_equal(aux_kurtosis(5, .5), -.4)
  expect_length(aux_kurtosis(5, .5), 1)
  expect_equal(aux_kurtosis(10, .2), .025)
})

# main functions

test_that("test that bin_choose works", {
  expect_equal(bin_choose(10,2), 45)
  expect_length(bin_choose(10, 2), 1)
  expect_error(bin_choose(10,11), "k cannot be larger than n")
})

test_that("test that bin_probability works", {
  expect_equal(bin_probability(10,.5,3), .1171875)
  expect_length(bin_probability(10, .5, 3), 1)
  expect_error(bin_probability(10, 4, 3), "prob has to be a number between 0 and 1")
})

test_that("test that bin_distribution works", {
  expect_s3_class(bin_distribution(10, .4), "bindis")
  expect_error(bin_distribution(10, 4), "prob has to be a number between 0 and 1")
  expect_equal(nrow(bin_distribution(10,.4)), 11)
  expect_equal(ncol(bin_distribution(10,.4)), 2)
})

test_that("test that bin_cumulative works", {
  expect_equal(nrow(bin_cumulative(10, .4)), 11)
  expect_equal(ncol(bin_cumulative(10, .4)), 3)
  expect_s3_class(bin_cumulative(10,.4), c('bincum', 'data.frame'))
})
