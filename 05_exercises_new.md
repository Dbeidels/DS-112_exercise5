---
title: 'Weekly Exercises #5'
author: "Daniel Beidelschies"
output: 
  html_document:
    keep_md: TRUE
    toc: TRUE
    toc_float: TRUE
    df_print: paged
    code_download: true
---





```r
library(tidyverse)     # for data cleaning and plotting
library(gardenR)       # for Lisa's garden data
library(lubridate)     # for date manipulation
library(openintro)     # for the abbr2state() function
library(palmerpenguins)# for Palmer penguin data
library(maps)          # for map data
library(ggmap)         # for mapping points on maps
library(gplots)        # for col2hex() function
library(RColorBrewer)  # for color palettes
library(sf)            # for working with spatial data
library(leaflet)       # for highly customizable mapping
library(ggthemes)      # for more themes (including theme_map())
library(plotly)        # for the ggplotly() - basic interactivity
library(gganimate)     # for adding animation layers to ggplots
library(transformr)    # for "tweening" (gganimate)
library(gifski)        # need the library for creating gifs but don't need to load each time
library(shiny)         # for creating interactive apps
theme_set(theme_minimal())
```


```r
# SNCF Train data
small_trains <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-26/small_trains.csv") 

# Lisa's garden data
data("garden_harvest")

# Lisa's Mallorca cycling data
mallorca_bike_day7 <- read_csv("https://www.dropbox.com/s/zc6jan4ltmjtvy0/mallorca_bike_day7.csv?dl=1") %>% 
  select(1:4, speed)

# Heather Lendway's Ironman 70.3 Pan Am championships Panama data
panama_swim <- read_csv("https://raw.githubusercontent.com/llendway/gps-data/master/data/panama_swim_20160131.csv")

panama_bike <- read_csv("https://raw.githubusercontent.com/llendway/gps-data/master/data/panama_bike_20160131.csv")

panama_run <- read_csv("https://raw.githubusercontent.com/llendway/gps-data/master/data/panama_run_20160131.csv")

#COVID-19 data from the New York Times
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
```

## Put your homework on GitHub!

Go [here](https://github.com/llendway/github_for_collaboration/blob/master/github_for_collaboration.md) or to previous homework to remind yourself how to get set up. 

Once your repository is created, you should always open your **project** rather than just opening an .Rmd file. You can do that by either clicking on the .Rproj file in your repository folder on your computer. Or, by going to the upper right hand corner in R Studio and clicking the arrow next to where it says Project: (None). You should see your project come up in that list if you've used it recently. You could also go to File --> Open Project and navigate to your .Rproj file. 

## Instructions

* Put your name at the top of the document. 

* **For ALL graphs, you should include appropriate labels and alt text.** 

* Feel free to change the default theme, which I currently have set to `theme_minimal()`. 

* Use good coding practice. Read the short sections on good code with [pipes](https://style.tidyverse.org/pipes.html) and [ggplot2](https://style.tidyverse.org/ggplot2.html). **This is part of your grade!**

* **NEW!!** With animated graphs, add `eval=FALSE` to the code chunk that creates the animation and saves it using `anim_save()`. Add another code chunk to reread the gif back into the file. See the [tutorial](https://animation-and-interactivity-in-r.netlify.app/) for help. 

* When you are finished with ALL the exercises, uncomment the options at the top so your document looks nicer. Don't do it before then, or else you might miss some important warnings and messages.

## Warm-up exercises from tutorial

  1. Choose 2 graphs you have created for ANY assignment in this class and add interactivity using the `ggplotly()` function.
  

```r
veggie_graph<- garden_harvest %>% 
  filter(vegetable=="beets") %>%
  group_by(variety,date) %>% 
  summarize(total_wt = sum(weight)) %>% 
  mutate(wt_lbs = total_wt*0.0022046, cum_wt_lbs = cumsum(wt_lbs)) %>% 
  ggplot(aes(x=date, y = cum_wt_lbs, color = variety))+
  geom_line()+
  labs(x="Date",y="Cumulative Weight in lbs", title = "Total Cumulative Weight over Time")
  

ggplotly(veggie_graph)
```

```{=html}
<div id="htmlwidget-823cf0bafae2cefb6c83" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-823cf0bafae2cefb6c83">{"x":{"data":[{"x":[18450,18451,18463,18470,18487],"y":[0.1366852,0.319667,0.5555592,0.8840446,7.021651],"text":["date: 2020-07-07<br />cum_wt_lbs: 0.1366852<br />variety: Gourmet Golden","date: 2020-07-08<br />cum_wt_lbs: 0.3196670<br />variety: Gourmet Golden","date: 2020-07-20<br />cum_wt_lbs: 0.5555592<br />variety: Gourmet Golden","date: 2020-07-27<br />cum_wt_lbs: 0.8840446<br />variety: Gourmet Golden","date: 2020-08-13<br />cum_wt_lbs: 7.0216510<br />variety: Gourmet Golden"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)","dash":"solid"},"hoveron":"points","name":"Gourmet Golden","legendgroup":"Gourmet Golden","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[18424,18431,18432,18434],"y":[0.0176368,0.0727518,0.0970024,0.2226646],"text":["date: 2020-06-11<br />cum_wt_lbs: 0.0176368<br />variety: leaves","date: 2020-06-18<br />cum_wt_lbs: 0.0727518<br />variety: leaves","date: 2020-06-19<br />cum_wt_lbs: 0.0970024<br />variety: leaves","date: 2020-06-21<br />cum_wt_lbs: 0.2226646<br />variety: leaves"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,186,56,1)","dash":"solid"},"hoveron":"points","name":"leaves","legendgroup":"leaves","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[18450,18452,18455,18461,18470,18473,18487],"y":[0.022046,0.1741634,0.3703728,0.749564,0.8575894,1.080254,6.3867262],"text":["date: 2020-07-07<br />cum_wt_lbs: 0.0220460<br />variety: Sweet Merlin","date: 2020-07-09<br />cum_wt_lbs: 0.1741634<br />variety: Sweet Merlin","date: 2020-07-12<br />cum_wt_lbs: 0.3703728<br />variety: Sweet Merlin","date: 2020-07-18<br />cum_wt_lbs: 0.7495640<br />variety: Sweet Merlin","date: 2020-07-27<br />cum_wt_lbs: 0.8575894<br />variety: Sweet Merlin","date: 2020-07-30<br />cum_wt_lbs: 1.0802540<br />variety: Sweet Merlin","date: 2020-08-13<br />cum_wt_lbs: 6.3867262<br />variety: Sweet Merlin"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(97,156,255,1)","dash":"solid"},"hoveron":"points","name":"Sweet Merlin","legendgroup":"Sweet Merlin","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":31.4155251141553},"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Total Cumulative Weight over Time","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[18420.85,18490.15],"tickmode":"array","ticktext":["Jun 15","Jul 01","Jul 15","Aug 01","Aug 15"],"tickvals":[18428,18444,18458,18475,18489],"categoryorder":"array","categoryarray":["Jun 15","Jul 01","Jul 15","Aug 01","Aug 15"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Date","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-0.33256391,7.37185171],"tickmode":"array","ticktext":["0","2","4","6"],"tickvals":[0,2,4,6],"categoryorder":"array","categoryarray":["0","2","4","6"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"Cumulative Weight in lbs","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":null,"bordercolor":null,"borderwidth":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"title":{"text":"variety","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"32c42de86066":{"x":{},"y":{},"colour":{},"type":"scatter"}},"cur_data":"32c42de86066","visdat":{"32c42de86066":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```
  

```r
lettuce_graph <- garden_harvest %>%
  filter(vegetable=="lettuce") %>%
  group_by(variety, date) %>%
  ggplot(aes(y=variety))+
  geom_bar()+
  labs(x="Times Harvested",y="Variety", title = "Variety of Lettuce Harvested")

ggplotly(lettuce_graph)
```

```{=html}
<div id="htmlwidget-ee14cf56c68725fcf292" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-ee14cf56c68725fcf292">{"x":{"data":[{"orientation":"v","width":[27,29,1,3,9],"base":[0.55,1.55,2.55,3.55,4.55],"x":[13.5,14.5,0.5,1.5,4.5],"y":[0.9,0.9,0.9,0.9,0.9],"text":["count: 27<br />variety: 0.9","count: 29<br />variety: 0.9","count:  1<br />variety: 0.9","count:  3<br />variety: 0.9","count:  9<br />variety: 0.9"],"type":"bar","textposition":"none","marker":{"autocolorscale":false,"color":"rgba(89,89,89,1)","line":{"width":1.88976377952756,"color":"transparent"}},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":148.310502283105},"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Variety of Lettuce Harvested","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-1.45,30.45],"tickmode":"array","ticktext":["0","10","20","30"],"tickvals":[0,10,20,30],"categoryorder":"array","categoryarray":["0","10","20","30"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Times Harvested","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.4,5.6],"tickmode":"array","ticktext":["Farmer's Market Blend","Lettuce Mixture","mustard greens","reseed","Tatsoi"],"tickvals":[1,2,3,4,5],"categoryorder":"array","categoryarray":["Farmer's Market Blend","Lettuce Mixture","mustard greens","reseed","Tatsoi"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"Variety","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":null,"bordercolor":null,"borderwidth":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"32c45820341f":{"y":{},"type":"bar"}},"cur_data":"32c45820341f","visdat":{"32c45820341f":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```
  
  2. Use animation to tell an interesting story with the `small_trains` dataset that contains data from the SNCF (National Society of French Railways). These are Tidy Tuesday data! Read more about it [here](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-02-26).


```r
small_trains %>% 
  filter(year == "2018") %>% 
  group_by(departure_station,month) %>%
  summarise(total_trips = sum(total_num_trips)) %>% 
  ungroup() %>% 
  complete(departure_station,month) %>% 
  group_by(departure_station) %>% 
  mutate(cum = cumsum(total_trips)) %>% 
  top_n(n = 10, wt = cum) %>% 
  arrange(month, cum) %>% 
  mutate(rank = 1:n()) %>% 
  ggplot(aes(x=cum,y = departure_station))+
  geom_col()+
  labs(x="Number of Trips",y="Station", title = "Cumulative Number of Trips Throughout 2018")+
  transition_time(month)
```

<img src="05_exercises_new_files/figure-html/unnamed-chunk-3-1.gif" title="bar graph of the cumulative number of trips of each departure station separated by months" alt="bar graph of the cumulative number of trips of each departure station separated by months"  />


## Garden data

  3. In this exercise, you will create a stacked area plot that reveals itself over time (see the `geom_area()` examples [here](https://ggplot2.tidyverse.org/reference/position_stack.html)). You will look at cumulative harvest of tomato varieties over time. I have filtered the data to the tomatoes and find the *daily* harvest in pounds for each variety. The `complete()` function creates a row for all unique `date`/`variety` combinations. If a variety is not harvested on one of the harvest dates in the dataset, it is filled with a value of 0. 
  You should do the following:
  * For each variety, find the cumulative harvest in pounds.  
  * Use the data you just made to create a static cumulative harvest area plot, with the areas filled with different colors for each variety and arranged (HINT: `fct_reorder()`) from most to least harvested weights (most on the bottom).  
  * Add animation to reveal the plot over date. Instead of having a legend, place the variety names directly on the graph (refer back to the tutorial for how to do this).


```r
garden_subset <- garden_harvest %>% 
  filter(vegetable == "tomatoes") %>% 
  group_by(date, variety) %>% 
  summarize(daily_harvest_lb = sum(weight)*0.00220462) %>% 
  ungroup() %>% 
  complete(variety, 
           date, 
           fill = list(daily_harvest_lb = 0)) %>% 
  group_by(variety) %>% 
  mutate(cum_harvest_lb = sum(daily_harvest_lb))


garden_subset%>% 
  ggplot(aes(x = date,y = daily_harvest_lb, fill = fct_reorder(variety,cum_harvest_lb)))+
  geom_area()+
  scale_fill_viridis_d(option = "mako", labels = c("grape" ="Grape", "volunteers" = "Volunteers"))+
  labs(x= "Date", y ="Daily Harvest", fill ="Variety", title ="Tomato Harvest by Date")
```

<img src="05_exercises_new_files/figure-html/unnamed-chunk-4-1.png" title="area graph of the cumulative harvest of each variety of tomato" alt="area graph of the cumulative harvest of each variety of tomato"  />

```r
garden_subset%>% 
  ggplot(aes(x = date,y = daily_harvest_lb, fill =fct_reorder(variety,cum_harvest_lb)))+
  geom_area()+
  scale_fill_viridis_d(option = "mako", labels = c("grape" ="Grape", "volunteers" = "Volunteers"))+
  labs(x= "Date", y ="Daily Harvest", fill ="Variety", title ="Tomato Harvest by Date")+
  transition_reveal(date)+
  geom_text(aes(label =variety))
```

<img src="05_exercises_new_files/figure-html/unnamed-chunk-4-1.gif" title="area graph of the cumulative harvest of each variety of tomato" alt="area graph of the cumulative harvest of each variety of tomato"  />

```r
  theme(legend.position = "none", legend.title = element_blank())
```

```
## List of 2
##  $ legend.title   : list()
##   ..- attr(*, "class")= chr [1:2] "element_blank" "element"
##  $ legend.position: chr "none"
##  - attr(*, "class")= chr [1:2] "theme" "gg"
##  - attr(*, "complete")= logi FALSE
##  - attr(*, "validate")= logi TRUE
```


## Maps, animation, and movement!

  4. Map Lisa's `mallorca_bike_day7` bike ride using animation! 
  Requirements:
  * Plot on a map using `ggmap`.  
  * Show "current" location with a red point. 
  * Show path up until the current point.  
  * Color the path according to elevation.  
  * Show the time in the subtitle.  
  * CHALLENGE: use the `ggimage` package and `geom_image` to add a bike image instead of a red point. You can use [this](https://raw.githubusercontent.com/llendway/animation_and_interactivity/master/bike.png) image. See [here](https://goodekat.github.io/presentations/2019-isugg-gganimate-spooky/slides.html#35) for an example. 
  * Add something of your own! And comment on if you prefer this to the static map and why or why not.
  

```r
mallorcamap <- get_stamenmap(
  bbox = c(left = 2.3716, bottom = 39.5317, right = 2.7287, top = 39.7067), 
  maptype = "terrain",
  zoom =10)

mallorca_bike_day7 %>% 
  mutate(time2 = lubridate::hms(time))%>% 

ggmap(mallorcamap)+
  geom_point(data = mallorca_bike_day7, 
             aes(x = lon, y = lat), 
             color = "blue", 
             alpha = 1, 
             size = 1) +
  geom_line(data = mallorca_bike_day7, 
            aes(x = lon, y = lat, color = ele))+
  theme_map()+
  labs(title = "Lisa's Bike Path, 16 March 2018", 
       subtitle = "Date and Time: {frame_along}",
       color = "Elevation",
       x = "",
       y = "")+
  theme(legend.position =  "bottom")+
  transition_reveal(time)+
  scale_color_viridis_c(option = "inferno")+ 
  exit_fade()
```

```
## Error: ggmap plots objects of class ggmap, see ?get_map
```

* I prefer the animation because it told me the exact route
  
  5. In this exercise, you get to meet Lisa's sister, Heather! She is a proud Mac grad, currently works as a Data Scientist where she uses R everyday, and for a few years (while still holding a full-time job) she was a pro triathlete. You are going to map one of her races. The data from each discipline of the Ironman 70.3 Pan Am championships, Panama is in a separate file - `panama_swim`, `panama_bike`, and `panama_run`. Create a similar map to the one you created with my cycling data. You will need to make some small changes: 1. combine the files putting them in swim, bike, run order (HINT: `bind_rows()`), 2. make the leading dot a different color depending on the event (for an extra challenge, make it a different image using `geom_image()!), 3. CHALLENGE (optional): color by speed, which you will need to compute on your own from the data. You can read Heather's race report [here](https://heatherlendway.com/2016/02/10/ironman-70-3-pan-american-championships-panama-race-report/). She is also in the Macalester Athletics [Hall of Fame](https://athletics.macalester.edu/honors/hall-of-fame/heather-lendway/184) and still has records at the pool. 
  

```r
panama <-bind_rows(panama_swim, panama_bike, panama_swim)

panamamap <- get_stamenmap(
  bbox = c(left = -79.6007, bottom = 8.8892, right = -79.4222, top = 90014),
  maptype = "terrain-lines",
  zoom =11)

ggmap(panama)+
  geom_point(panama, 
             aes(x = lon, y = lat), 
             color = "blue", 
             alpha = 1, 
             size = 4) +
  geom_line(panama,
            aes(x = lon, y = lat))+
  theme_map()+
  labs(x = "",
       y ="",
       color = "",
       subtitle = "Date and Time: {frame_along}",
       title = "Ironman Path")+
  theme(legend.position = "bottom")+
  transition_reveal(time)+
  scale_color_viridis_d(option ="inferno")+
  exit_fade()
```

```
## Error: ggmap plots objects of class ggmap, see ?get_map
```
  
## COVID-19 data

  6. In this exercise you will animate a map of the US, showing how cumulative COVID-19 cases per 10,000 residents has changed over time. This is similar to exercises 11 & 12 from the previous exercises, with the added animation! So, in the end, you should have something like the static map you made there, but animated over all the days. The code below gives the population estimates for each state and loads the `states_map` data. Here is a list of details you should include in the plot:
  
  * Put date in the subtitle.   
  * Because there are so many dates, you are going to only do the animation for the the 15th of each month. So, filter only to those dates - there are some lubridate functions that can help you do this.   
  * Use the `animate()` function to make the animation 200 frames instead of the default 100 and to pause for 10 frames on the end frame.   
  * Use `group = date` in `aes()`.   
  * Comment on what you see.  

```r
census_pop_est_2018 <- read_csv("https://www.dropbox.com/s/6txwv3b4ng7pepe/us_census_2018_state_pop_est.csv?dl=1") %>% 
  separate(state, into = c("dot","state"), extra = "merge") %>% 
  select(-dot) %>% 
  mutate(state = str_to_lower(state))

states_map <- map_data("state")
```



```r
state_map = map_data("state")

state_gif<-covid19 %>% 
  arrange(desc(date)) %>% 
  mutate(state = str_to_lower(state)) %>% 
  mutate(numberrow=1:n()) %>% 
  left_join(census_pop_est_2018, by = "state") %>%
  mutate(new_cases = (cases/est_pop_2018)*10000) %>%
  ggplot() +
  geom_map(map = state_map,
           aes(map_id = state,
               fill = new_cases)) +
  #This assures the map looks decently nice:
  expand_limits(x = state_map$long, y = state_map$lat) +
  theme_map()+
  scale_fill_viridis_c(option = "inferno", direction = -1)+
  labs(title="Most Recent Covid Cases in the USA", caption = "Plot created by Daniel Beidelschies", fill ="Cases", subtitle = "Date: {frame_along}")+
  transition_reveal(date)

animate(state_gif, nframes = 200, duration = 10)
```

![](05_exercises_new_files/figure-html/map of the US and the number of cases per 100000 people by population-1.gif)<!-- -->

* We see that over time the midwestern states were the first states that garnered more cases compared to states with bigger populations

## Your first `shiny` app (for next week!)

  7. This app will also use the COVID data. Make sure you load that data and all the libraries you need in the `app.R` file you create. You should create a new project for the app, separate from the homework project. Below, you will post a link to the app that you publish on shinyapps.io. You will create an app to compare states' daily number of COVID cases per 100,000 over time. The x-axis will be date. You will have an input box where the user can choose which states to compare (`selectInput()`), a slider where the user can choose the date range, and a submit button to click once the user has chosen all states they're interested in comparing. The graph should display a different line for each state, with labels either on the graph or in a legend. Color can be used if needed. 
  
Put the link to your app here: https://daniel-beidelschies.shinyapps.io/app_ex_5/?_ga=2.240558979.1208563929.1648754543-1644272562.1648581272
  
## GitHub link

  8. Below, provide a link to your GitHub repo with this set of Weekly Exercises. 
  
https://github.com/Dbeidels/DS-112_exercise5


**DID YOU REMEMBER TO UNCOMMENT THE OPTIONS AT THE TOP?**
