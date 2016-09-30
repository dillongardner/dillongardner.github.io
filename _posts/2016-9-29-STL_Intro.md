---
layout: post
title: Seasonal Decomposition Intro
---

I've spent a lot of time working with time series data. On nearly any project, one of the first issues that crops up is the seasonality of the data. It is easy enough to dump the data into a decomposition function and get good results. For example, `seasonal_decompose` in Python's `statsmodels` and `decompose` or `stl` in base R.

But I've always been uncomfortable with how much of these functions are black boxes. Even good websites that I generally adore only explain how to use these functions, not how they work. For example, Rob Hyndman's excellent [book][hyndman] on time series analysis is so thorough, except for STL.

I am going to try to delve a bit more into how the STL function works. This will be in three parts. Part I will cover a basic use of STL on traffic data. Part II will go into the weeds of how the decomposition works. In Part III, I'll explain a key advantage of STL over other means of decomposition: how can seamlessly handle missing data.


[hyndman]: https://www.otexts.org/fpp/6/5
