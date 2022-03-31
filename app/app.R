
library(shiny)
library(tidyverse)
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
census_pop_est_2018 <- read_csv("https://www.dropbox.com/s/6txwv3b4ng7pepe/us_census_2018_state_pop_est.csv?dl=1") %>% 
  separate(state, into = c("dot","state"), extra = "merge") %>% 
  select(-dot) %>% 
  mutate(state = str_to_title(state))

ui <- fluidPage(selectInput(inputId = "state",
                            label ="State:",
                            choices = unique(covid19$state),
                            multiple = TRUE),
                dateRangeInput(inputId = "date",
                               label = "Date",
                               start="2020-01-21",
                               end="2022-03-31",
                               min="2020-01-21",
                               max="2022-03-31",
                               format = "mm/dd/yy",
                               sep =""),
                submitButton(text = "Submit"),
                plotOutput(outputId = "timeplot"))
server <- function(input, output) {
  output$timeplot <- renderPlot(
    covid19 %>% 
      inner_join(census_pop_est_2018, by = "state") %>% 
      filter(state %in% c(input$state)) %>% 
      mutate(lag1day = lag(cases,1, order_by = cases),New_daily_cases = ((cases - lag1day)/est_pop_2018)*100000)%>%
      replace_na(list(New_daily_cases=0,lag1day = 0)) %>% 
      ggplot(aes(x = date, y = New_daily_cases, color = state))+
      geom_line()+
      labs(x="Date",y="Daily Cases")+
      xlim(input$date)
  )
}
shinyApp(ui = ui, server = server)