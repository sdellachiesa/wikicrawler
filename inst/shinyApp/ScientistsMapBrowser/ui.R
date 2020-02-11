

header <<- dashboardHeader(titleWidth = 350)

anchor <<- tags$a(href='https://en.wikipedia.org/wiki/Lists_of_scientists',
                  tags$img(style="vertical-align: bottom;width: 350px;",
                           src='Logo.png'),
                  class='tit')

#header$children[[2]]$children <<- tags$div(anchor,class = 'name')





body <- dashboardBody(
  #tags$img(src = "./data/KST_Logo.jpg"),
  tags$head(tags$link(rel = "stylesheet",type = "text/css", href = "custom.css"),
              tags$link(rel="shortcut icon", href="www/Logo.png")
  ),
  tags$a(
    href="https://gitlab.inf.unibz.it/rmeetupbz/wikicrawler",
    tags$img(
      style="position: absolute; top: 0; right: 0; border: 0;z-index: 5;z-index: 5000;",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_white_ffffff.png?resize=149%2C149",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_orange_ff7600.png?resize=149%2C149",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_gray_6d6d6d.png?resize=149%2C149",
      src="https://github.blog/wp-content/uploads/2008/12/forkme_right_red_aa0000.png?resize=149%2C149",
      alt="Fork me on GitHub",
      width="110",
      height="110",
      #class="github-fork-ribbon"
      class="attachment-full size-full",
      #data-recalc-dims="1"
    )
    
  ),
  
  
  tabItems(
    tabItem(tabName = "data",
            fluidRow(
              column(width = 6,
                     box(width = NULL,  #,status = "warning"
                         sliderInput(inputId = "slider",
                                     label = "Choose time period [Years]",
                                     min = min(GeoScientists_df$Born),
                                     max = max(GeoScientists_df$Born),
                                     value = c(min,max),
                                     step = 10)
                     )
              )
            ),
            fluidRow(
              column(width = 12,
                     box(width = NULL,
                         tabsetPanel(type = "tabs",
                                     tabPanel("Map", leafletOutput("my_leaf")),
                                     tabPanel("Table", DT::dataTableOutput("my_table")
                                     )
                         )
                     )
              )
            ),
            
    ),
    tabItem(# the about page
      tabName = "about",
      tabPanel("About", box(width = NULL,
                            #about$value
                            htmlOutput("about_out")
      )
      )
    )
  )
)

dashboardSidebar<- dashboardSidebar(disable = FALSE,
                                    width = NULL,
                                    sidebarMenuOutput(outputId = 'data'),
                                    sidebarMenuOutput(outputId = 'about')
                                    #sidebarMenu(
                                    # menuItem("Info:To Be Defined")
)

dashboardPage(title = "Scietist Browser",
              header,
              dashboardSidebar,
              body
)
